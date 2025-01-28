require 'rails_helper'

RSpec.describe Guests::PhoneNumber, type: :model do
  let(:guest) { create(:guest) }  # Assuming you have a factory for guest
  let(:valid_phone_number) { "+639123456789" }
  let(:invalid_phone_number) { "12345" }

  describe 'validations' do
    it 'is valid with a valid number and type' do
      phone = described_class.new(number: valid_phone_number, phone_type: 'primary', guest: guest)
      expect(phone).to be_valid
    end

    it 'is invalid without a number' do
      phone = described_class.new(phone_type: :primary, guest: guest)
      expect(phone).to_not be_valid
      expect(phone.errors[:number]).to include("can't be blank")
    end
  end

  describe 'phone number normalization' do
    it 'normalizes the phone number to E.164 format' do
      phone = described_class.new(number: "+639123456789", phone_type: :primary, guest: guest)
      phone.valid?  # Trigger validation and normalization
      expect(phone.number).to eq("+639123456789")
    end

    it 'normalizes a phone number without a country code to E.164 format' do
      phone = described_class.new(number: "09123456789", phone_type: :primary, guest: guest)
      phone.valid?  # Trigger validation and normalization
      expect(phone.number).to eq("+09123456789")  # Ensure it's normalized to E.164 format
    end
  end
end
