class Guests::PhoneNumber < ApplicationRecord
  belongs_to :guest
  validates :number, presence: true
  validates :phone_type, presence: true

  # Format the number to E.164
  before_validation :normalize_phone_number

  private

  def normalize_phone_number
    self.number = Phonelib.parse(number).e164 if number.present?
  end
end
