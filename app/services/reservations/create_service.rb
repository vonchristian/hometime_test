class Reservations::CreateService < ActiveInteraction::Base
  hash :guest, strip: false do
    string :email
    string :first_name, default: nil
    string :last_name, default: nil
    string :phone, default: nil
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
    guest = find_or_create_guest
    create_reservation(guest)
  rescue ActiveRecord::RecordInvalid => e
    errors.add(:base, e.message)
    nil
  end

  private

  def find_or_create_guest
    Guest.find_or_create_by!(email: guest[:email]) do |g|
      g.first_name = guest[:first_name]
      g.last_name = guest[:last_name]
      g.phone = guest[:phone]
    end
  end

  def create_reservation(guest)
    guest.reservations.create!(
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
end
