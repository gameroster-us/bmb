class PaymentsController < ApplicationController
  def index
  end

  def create
    order_id = params[:payment][:order_id]
    total_payment = params[:payment][:amount]
    user_id = params[:payment][:user_id]
    gslot_ids = JSON.parse(params[:payment][:gslot_id]) # Convert the string to an array of gslot IDs

    authorize Booking
    bookings_saved = Booking.transaction do
      gslot_ids.map do |gslot_id|
        Booking.create(
          order_id: order_id,
          gslot_id: gslot_id,
          total_payment: total_payment,
          user_id: user_id
        )
      end
   end

  if bookings_saved.all?(&:persisted?)
    # Payment data saved successfully
    redirect_to payment_success_path
  else
    # Failed to save payment data
    render json: { error: 'Failed to save payment data' }, status: :unprocessable_entity
  end
  end
  def success
    authorize Booking
  end

  def show 

  end
end
