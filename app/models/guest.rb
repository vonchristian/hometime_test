class Guest < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :phone_numbers, class_name: "Guests::PhoneNumber", dependent: :destroy

  validates :email, presence: true, uniqueness: true
end
