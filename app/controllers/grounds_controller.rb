class GroundsController < ApplicationController
  before_action :authenticate_user!
  def new
    
    @organization = Organization.find(params[:organization_id])
    authorize @organization

    @ground = @organization.grounds.build
    authorize @organization
  end

  def create

    @organization = Organization.find(params[:organization_id])
    authorize @organization
    @ground = @organization.grounds.build(ground_params)
    authorize @organization
    if @ground.save
      redirect_to organization_path(@organization), notice: 'Ground created successfully.'
    else
      render :new
    end
  end

  private
  def ground_params
    params.require(:ground).permit(:name, :location)
  end
end
