class Reservations::PayloadNormalizer < ActiveInteraction::Base
  hash :payload, strip: false

  def execute
    {
      start_date: data[:start_date],
      end_date: data[:end_date],
      nights: nights,
      guests: guests,
      adults: adults,
      children: children,
      infants: infants,
      status: status,
      pricing: pricing_details,
      guest: guest_details
    }

  rescue StandardError => e
    errors.add(:base, e.message)
    nil
  end

  def data
    @data ||= payload[:reservation] || payload
  end

  def nights
    data[:nights] || data[:number_of_guests]
  end

  def guests
    data[:guests] || data[:number_of_guests]
  end

  def adults
    data[:adults] || data.dig(:guest_details, :number_of_adults)
  end

  def children
    data[:children] || data.dig(:guest_details, :number_of_children)
  end

  def infants
    data[:infants] || data.dig(:guest_details, :number_of_infants)
  end

  def status
    data[:status] || data[:status_type]
  end

  def pricing_details
    {
      currency: data[:currency] || data[:host_currency],
      payout_price_cents: (data[:payout_price] || data[:expected_payout_amount]).to_i * 100,
      security_price_cents: (data[:security_price] || data[:listing_security_price_accurate]).to_i * 100,
      total_price_cents: (data[:total_price] || data[:total_paid_amount_accurate]).to_i * 100
    }
  end

  def guest_details
    {
      email: data[:guest_email] || data.dig(:guest, :email),
      first_name: data[:guest_first_name] || data.dig(:guest, :first_name),
      last_name: data[:guest_last_name] || data.dig(:guest, :last_name),
      phone_numbers: (data[:guest_phone_numbers] || [ data.dig(:guest, :phone) ])
    }
  end
end
