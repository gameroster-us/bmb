class BookingPolicy < ApplicationPolicy

    def create?
      true
    end
    def success?
        true
    end
  
    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
  