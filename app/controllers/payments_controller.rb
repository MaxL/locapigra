class PaymentsController < ApplicationController
  load_and_authorize_resource

  def index
    @payments = Payment.all
  end

  def new
    @payment = Payment.new
  end

  def create
    @payment = Payment.new(payment_params)
    if @payment.save
      flash[:success] = "Payment successfully created"
      redirect_to payments_path
    else
      flash[:danger] = "Something went wrong"
      render 'new'
    end
  end

  def edit
    @payment = Payment.find(params[:id])
  end

  def update
    if @payment.update_attributes(payment_params)
      flash[:success] = "Payment successfully updated"
      redirect_to payments_path
    else
      flash[:danger] = "Something went wrong"
      render 'edit'
    end
  end

  private

    def payment_params
      params.require(:payment).permit(:name, :price, :fee_type, :active)
    end
end
