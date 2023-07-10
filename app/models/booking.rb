class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :gslot 
  def self.booking_params(params)
    params.require(:payment).permit(:order_id, :total_payment, :user_id, :gslot_id)
  end
end
