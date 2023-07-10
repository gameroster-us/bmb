class OrganizationPolicy < ApplicationPolicy
    def index?
      true
    end
  
    def show?
      true
    end

    def new? 
    user.admin?
    end

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
  