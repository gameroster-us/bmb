class BookingPolicy < ApplicationPolicy

    def create?
      true
    end
    def index?
     true
    end
    def success?
        true
    end
  
    class Scope < Scope
      def resolve
        Booking.all
      end
    end
  end
  