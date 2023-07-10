class UserPolicy < ApplicationPolicy
    def index?
      true
    end

    def new? 
      true
    end

    def create?
      true
    end
    # Add additional authorization rules for other actions if needed
  
    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
 