require 'rails_helper'

RSpec.describe Guest, type: :model do
  describe 'associations' do
    it { should have_many(:reservations).dependent(:destroy) }
  end

  describe 'validations' do
    it { should validate_presence_of(:email) }
    it 'validate_uniqueness_of(:email)' do
      create(:guest, email: 'test@test.com')
      record = build(:guest, email: 'test@test.com')
      record.save

      expect(record.errors[:email]).to match_array('has already been takent')
    end
  end
end
