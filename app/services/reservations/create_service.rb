class Reservations::CreateService < ActiveInteraction::Base
  hash :guest, strip: false do
    string :email
    string :first_name, default: nil
    string :last_name, default: nil
    array :phone_numbers, default: []
  end

  string :start_date
  string :end_date
  integer :nights
  integer :guests
  integer :adults
  integer :children
  integer :infants
  string :status

  hash :pricing, strip: false do
    string :currency
    decimal :payout_price_cents
    decimal :security_price_cents
    decimal :total_price_cents
  end

  def execute
    create_phone_numbers
    create_reservation
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, e.message)
    nil
  end

  private

  def find_guest
    @find_guest ||= existing_guest || create_new_guest
  end

  def existing_guest
    Guest.find_by(email: guest[:email])
  end

  def create_new_guest
    Guest.create!(email: guest[:email], first_name: guest[:first_name], last_name: guest[:last_name])
  end

  def create_reservation
    find_guest.reservations.create!(
      start_date: start_date,
      end_date: end_date,
      nights: nights,
      guests: guests,
      adults: adults,
      children: children,
      infants: infants,
      status: status,
      pricing_attributes: pricing
    )
  end

  def create_phone_numbers
    return if guest[:phone_numbers].blank?

    guest[:phone_numbers].each_with_index do |phone_number, indx|
      find_guest.phone_numbers.create(number: phone_number, phone_type: indx.zero? ? "primary": "secondary")
    end
  end
end
