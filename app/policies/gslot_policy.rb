class GslotPolicy < ApplicationPolicy
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

  def get_date?
    user.admin?
  end

    def payment?
    true
    end
    # Add additional authorization rules for other actions if needed
  
    class Scope < Scope
      def resolve
        p "8888888888888888"
        p "8888888888888888"
        p "8888888888888888"
        p "8888888888888888"
        p "8888888888888888"
        p "8888888888888888"

        scope.all
      end
    end
  end
  