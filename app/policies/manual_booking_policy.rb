class ManualBookingPolicy < ApplicationPolicy


    def create?
    user.admin?
    end
    # Add additional authorization rules for other actions if needed
  
    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
  