class BookingsController < ApplicationController
    

    def index 
       authorize Booking 
      @bookings = policy_scope(Booking).all
      if current_user.admin?
        @bookings = Booking.all
        # @bookings = Booking.all.group_by(&:order_id).values.map do |grouped_bookings|
        #   first_booking = grouped_bookings.first
        #   slots = grouped_bookings.map(&:gslot_id).join(', ')
        #   first_booking.tap { |booking| booking.gslot_id = slots }
        # end
      else
        @bookings = Booking.where(user_id: current_user.id).group_by(&:order_id).values.map do |grouped_bookings|
          first_booking = grouped_bookings.first
          slots = grouped_bookings.map(&:gslot_id).join(', ')
          first_booking.tap { |booking| booking.gslot_id = slots }
        end
        
    
      end
      
       
    end

    def show 
      authorize Booking 
       @bookings = policy_scope(Booking).find_by(user_id: :current_user.id)
    end 

    def success
      authorize Booking 
    end
end
