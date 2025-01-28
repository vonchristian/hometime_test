class Guest < ApplicationRecord
  has_many :reservations, dependent: :destroy
  validates :email, presence: true, uniqueness: true
end
