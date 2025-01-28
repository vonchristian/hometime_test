class Reservations::Pricing < ApplicationRecord
  self.table_name = "reservation_pricings"

  belongs_to :reservation
  monetize :payout_price_cents, with_model_currency: :currency, as: :payout_price
  monetize :security_price_cents, with_model_currency: :currency, as: :security_price
  monetize :total_price_cents, with_model_currency: :currency, as: :total_price

  validates :currency, :payout_price_cents, :security_price_cents, :total_price_cents, presence: true
  validates :payout_price_cents, :security_price_cents, :total_price_cents, numericality: { greater_than_or_equal_to: 0 }
end
