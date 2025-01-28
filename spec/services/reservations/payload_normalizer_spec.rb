require 'rails_helper'

RSpec.describe Reservations::PayloadNormalizer, type: :service do
  let(:result) { described_class.run!(payload: payload) }

  context 'with payload #1 format' do
    let(:payload) do
      {
      start_date: '2021-03-12',
      end_date: '2021-03-16',
      nights: 4,
      guests: 4,
      adults: 2,
      children: 2,
      infants: 0,
      status: 'accepted',
      guest: {
        id: 1,
        first_name: 'Wayne',
        last_name: 'Woodbridge',
        phone: '639123456789',
        email: 'wayne_woodbridge@bnb.com'
      },
      currency: 'AUD',
      payout_price: '3800.00',
      security_price: '500',
      total_price: '4500.00'
    }
    end

    it { expect(result[:start_date]).to eq('2021-03-12') }
    it { expect(result[:end_date]).to eq('2021-03-16') }
    it { expect(result[:nights]).to eq(4) }
    it { expect(result[:guests]).to eq(4) }
    it { expect(result[:adults]).to eq(2) }
    it { expect(result[:children]).to eq(2) }
    it { expect(result[:infants]).to eq(0) }
    it { expect(result[:status]).to eq('accepted') }
    it { expect(result[:pricing]).to eq({ currency: "AUD", payout_price_cents: 380000, security_price_cents: 50000, total_price_cents: 450000 }) }
    it { expect(result[:guest]).to eq({ email: "wayne_woodbridge@bnb.com", first_name: "Wayne", last_name: "Woodbridge", phone: "639123456789" }) }
  end

  context 'with payload #2 format' do
    let(:payload) do
      {
        reservation: {
          start_date: '2021-03-12',
          end_date: '2021-03-16',
          expected_payout_amount: '3800.00',
          guest_details: {
            localized_description: '4 guests',
            number_of_adults: 2,
            number_of_children: 2,
            number_of_infants: 0
          },
          guest_email: 'wayne_woodbridge@bnb.com',
          guest_first_name: 'Wayne',
          guest_id: 1,
          guest_last_name: 'Woodbridge',
          guest_phone_numbers: [
            '639123456789',
            '639123456789'
          ],
          listing_security_price_accurate: '500.00',
          host_currency: 'AUD',
          nights: 4,
          number_of_guests: 4,
          status_type: 'accepted',
          total_paid_amount_accurate: '4500.00'
        }
      }
    end

    it { expect(result[:start_date]).to eq('2021-03-12') }
    it { expect(result[:end_date]).to eq('2021-03-16') }
    it { expect(result[:nights]).to eq(4) }
    it { expect(result[:guests]).to eq(4) }
    it { expect(result[:adults]).to eq(2) }
    it { expect(result[:children]).to eq(2) }
    it { expect(result[:infants]).to eq(0) }
    it { expect(result[:status]).to eq('accepted') }
    it { expect(result[:pricing]).to eq({ currency: "AUD", payout_price_cents: 380000, security_price_cents: 50000, total_price_cents: 450000 }) }
    it { expect(result[:guest]).to eq({ email: "wayne_woodbridge@bnb.com", first_name: "Wayne", last_name: "Woodbridge", phone: "639123456789" }) }
  end
end
