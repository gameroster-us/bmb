class GslotsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_ground, except: :payment

  def index
    @ground =  Ground.find(params[:ground_id])
    @q = @ground.gslots.ransack(params[:q])
    # Set the default date filter to today's date
    @q.date_cont ||= Date.today
    @gslots =  @q.result(distinct: true).order(date: :asc, start_time: :asc, charge: :asc)
    @gslots = authorize policy_scope(@gslots)
  end
  
  def new
    get_date
    @gslot = @ground.gslots.build
    authorize @gslot
  end

  def get_date
    date = params[:id]
    @test_result = authorize Gslot.where(date: params[:id], ground_id: set_ground)
    authorize @test_result
    respond_to do |format|
      format.js { render json: @test_result.to_json }
      format.html
    end
  end

  def create
    flashflag = false
    @ground = Ground.find(params[:ground_id])
    authorize @ground
    slot_times = params[:slot_times]
    end_times = params[:end_times]

    if slot_times.present? 
      slot_times.each_with_index do |start_time, index|
        end_time = end_times[index]
    
        @gslot = @ground.gslots.build(gslot_params)
        @gslot.start_time = start_time
        @gslot.end_time = end_time
    
        if @gslot.save
          # Slot record saved successfully
        else
          flashflag = true
          flash[:alert] = "Error: All Fields are Required | Duplicate record exists."
          break  # Break the loop if a duplicate record is found
        end
      end
      p flashflag 
      if flashflag
        redirect_to new_ground_gslot_path(@ground), alert: flash[:alert]
      else
        redirect_to ground_gslots_path(@ground), notice: "Gslot was successfully created."
      end
    else
      flash[:alert] = "Error: All Fields are Required | Duplicate record exists."
      redirect_to new_ground_gslot_path(@ground), alert: flash[:alert]
    end
  end
  
  def payment
    authorize Gslot
    @selected_slots = params[:selected_slots]
    @gslot =  Gslot.find(@selected_slots)
    p @gslot  
    
    # @gslot = Gslot.find(params[:id])
    # @ground = Ground.find(params[:ground_id])
    # @organization = Organization.find(params[:organization_id])
    @charge = 0
    @gslot.each do |gslot|
      @charge += gslot.charge.to_i
    end
    @charge = @charge * 100 
    razorpay_order = Razorpay::Order.create(amount: @charge, currency: 'INR')
    @order_id = razorpay_order.id
  
   
  end
  def data
    @selected_slots = params[:selected_slots]
    @gslot =  Gslot.find(@selected_slots)
    p @gslot  
  end

  def destroy
    @gslot = @ground.gslots.find(params[:id])
    @gslot.destroy
    redirect_to ground_gslots_path(@ground), notice: "Gslot was successfully deleted."
  end

  private

  def set_ground
    @ground = Ground.find(params[:ground_id])
  end

  def gslot_params
    params.require(:gslot).permit(:date, :charge)
  end
end
