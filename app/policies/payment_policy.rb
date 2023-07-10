class PaymentPolicy < ApplicationPolicy
    
  

    def create?
      user.user?
    end
   
    
  
    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
  