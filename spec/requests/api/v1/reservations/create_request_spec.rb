require 'rails_helper'

RSpec.describe 'Api::V1::ReservationsController', type: :request do
  describe 'POST /api/v1/reservations' do
    let(:valid_payload) do
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

    let(:invalid_payload) do
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
        email: nil
      },
      currency: 'AUD',
      payout_price: '3800.00',
      security_price: '500',
      total_price: '4500.00'
    }
    end

    context 'with valid parameters' do
      it 'creates a reservation and returns status created' do
        post '/api/v1/reservations', params: valid_payload

        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body).keys).to match_array([ "id", "guest_id", "start_date", "end_date", "nights", "guests", "adults", "children", "infants", "status", "created_at", "updated_at" ])
      end
    end

    context 'with invalid parameters' do
      it 'does not create a reservation and returns errors' do
        post '/api/v1/reservations', params: invalid_payload

        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to have_key('error')
      end
    end
  end
end
