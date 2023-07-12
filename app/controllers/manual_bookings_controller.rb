# app/controllers/manual_bookings_controller.rb
class ManualBookingsController < ApplicationController
    def create
  order_id = params[:payment][:order_id]
  total_payment = params[:payment][:total_payment]
  gslot_ids = JSON.parse(params[:payment][:gslot_id]) # Convert the string to an array of gslot IDs

  authorize Booking
  bookings_saved = Booking.transaction do
    gslot_ids.map do |gslot_id|
      Booking.create(
        order_id: order_id,
        gslot_id: gslot_id,
        total_payment: total_payment,
      )
    end
  end

  if bookings_saved.all?(&:persisted?)
    redirect_to booking_success_path
  else
    render json: { error: 'Failed to save payment data' }, status: :unprocessable_entity
  end
end

  end
  