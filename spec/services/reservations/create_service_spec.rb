require 'rails_helper'

RSpec.describe Reservations::CreateService, type: :service do
  describe '#execute' do
    let(:guest_params) do
      {
        email: '1guest@example.com',
        first_name: 'John',
        last_name: 'Doe',
        phone: '1234567890'
      }
    end

    let(:pricing_params) do
      {
        currency: 'USD',
        payout_price_cents: 10050,
        security_price_cents: 5000,
        total_price_cents: 15050
      }
    end

    let(:valid_params) do
      {
        guest: guest_params,
        start_date: '2025-02-01',
        end_date: '2025-02-05',
        nights: 4,
        guests: 2,
        adults: 2,
        children: 0,
        infants: 0,
        status: 'confirmed',
        pricing: pricing_params
      }
    end

    context 'when all parameters are valid' do
      let(:guest) { Guest.find_by(email: guest_params[:email]) }
      let(:reservation) { guest.reservations.last }
      let(:pricing) { reservation.pricing }

      it 'creates a guest, reservation and pricing' do
        expect {
          described_class.run!(valid_params)
        }.to change(Guest, :count).by(1)
          .and change(Reservation, :count).by(1)
          .and change(Reservations::Pricing, :count).by(1)
      end

      context 'when checking attrs are correct' do
        before { described_class.run!(valid_params) }

        describe 'assigns correct guest details' do
          it { expect(guest.first_name).to eq(guest_params[:first_name]) }
          it { expect(guest.last_name).to eq(guest_params[:last_name]) }
          it { expect(guest.phone).to eq(guest_params[:phone]) }
        end

        describe 'assigns correct reservation details' do
          it { expect(reservation.start_date.to_s).to eq(valid_params[:start_date]) }
          it { expect(reservation.end_date.to_s).to eq(valid_params[:end_date]) }
          it { expect(reservation.nights).to eq(valid_params[:nights]) }
          it { expect(reservation.guests).to eq(valid_params[:guests]) }
          it { expect(reservation.adults).to eq(valid_params[:adults]) }
          it { expect(reservation.children).to eq(valid_params[:children]) }
          it { expect(reservation.infants).to eq(valid_params[:infants]) }
          it { expect(reservation.status).to eq(valid_params[:status]) }
          it { expect(pricing.currency).to eq(pricing_params[:currency]) }
        end

        describe 'assigns correct pricing details' do
          it { expect(pricing.payout_price_cents).to eq(pricing_params[:payout_price_cents]) }
          it { expect(pricing.security_price_cents).to eq(pricing_params[:security_price_cents]) }
          it { expect(pricing.total_price_cents).to eq(pricing_params[:total_price_cents]) }
        end
      end

      it 'does not create a duplicate guest if one already exists' do
        Guest.create!(guest_params)

        expect {
          described_class.run!(valid_params)
        }.to change(Guest, :count).by(0)
          .and change(Reservation, :count).by(1)
      end
    end

    context 'when parameters are invalid' do
      it 'does not create a reservation if required parameters are missing' do
        invalid_params = valid_params.except(:start_date)

        result = described_class.run(invalid_params)

        expect(result).to be_invalid
        expect(result.errors.full_messages).to include("Start date is required")
        expect(Reservation.count).to eq(0)
      end

      it 'does not create a guest or reservation if guest email is missing' do
        invalid_params = valid_params.deep_merge(guest: { email: nil })

        result = described_class.run(invalid_params)

        expect(result).to be_invalid
        expect(result.errors.full_messages).to include("Guest email is required")
        expect(Guest.count).to eq(0)
        expect(Reservation.count).to eq(0)
      end
    end
  end
end
