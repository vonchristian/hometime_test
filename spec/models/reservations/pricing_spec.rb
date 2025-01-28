require 'rails_helper'

RSpec.describe Reservations::Pricing, type: :model do
  describe 'associations' do
    it { should belong_to(:reservation) }
  end

  describe 'validations' do
    it { should validate_presence_of(:currency) }
    it { should validate_presence_of(:payout_price_cents) }
    it { should validate_presence_of(:security_price_cents) }
    it { should validate_presence_of(:total_price_cents) }
    it { should validate_numericality_of(:payout_price_cents).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:security_price_cents).is_greater_than_or_equal_to(0) }
    it { should validate_numericality_of(:total_price_cents).is_greater_than_or_equal_to(0) }
  end
end
