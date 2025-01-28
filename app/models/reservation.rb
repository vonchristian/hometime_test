class Reservation < ApplicationRecord
  belongs_to :guest
  has_one :pricing, class_name: "Reservations::Pricing", dependent: :destroy

  accepts_nested_attributes_for :pricing

  validates :start_date, :end_date, :status, presence: true
end
