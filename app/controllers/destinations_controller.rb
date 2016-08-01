class DestinationsController < ApplicationController
  load_and_authorize_resource

  def index
    @destinations = Destination.all
  end

  def new
    @destination = Destination.new
  end

  def create
    @destination = Destination.new(destination_params)
    if @destination.save
      flash[:success] = "Destination successfully created"
      redirect_to destinations_path
    else
      flash[:danger] = "Something went wrong"
      render 'new'
    end
  end

  def edit
    @destination = Destination.find(params[:id])
  end

  def update
    if @destination.update_attributes(destination_params)
      flash[:success] = "Destination successfully updated"
      redirect_to destinations_path
    else
      flash[:danger] = "Something went wrong"
      render 'edit'
    end
  end

  private
    def destination_params
      params.require(:destination).permit(:country_code, :country_name, :shipping_price)
    end
end
