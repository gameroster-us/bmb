class OrganizationsController < ApplicationController
    
    def index
        if current_user.admin?
         p true
         p true
        else
          p false
          p false
        end
        
       
        
        authorize Organization 
        @organization = policy_scope(Organization).all
    end

    def new
        authorize Organization
        @organization = Organization.new
    end 
      
    def create
    @organization = Organization.new(organization_params)
    authorize @organization

    if @organization.save
        redirect_to organizations_path
    else
        render :new
    end
    end
    
    def show
        @organization = Organization.find(params[:id])
        authorize @organization
    end
    private
    
    def organization_params
    params.require(:organization).permit(:name, :address)
    end
end
