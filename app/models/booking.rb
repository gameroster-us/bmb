class Booking < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :gslot 
  def self.booking_params(params)
    params.require(:payment).permit(:order_id, :total_payment, :gslot_id)
  end
end
