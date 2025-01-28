class Api::V1::ReservationsController < ApplicationController
  def create
    reservation_payload = Reservations::PayloadNormalizer.run!(payload: params.to_unsafe_h)
    result = Reservations::CreateService.run(reservation_payload)

    if result.valid?
      render json: result.result, status: :created
    else
      render json: { error: result.errors.full_messages }, status: :unprocessable_entity
    end
  end
end
