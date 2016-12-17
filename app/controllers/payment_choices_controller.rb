class PaymentChoicesController < ApplicationController
  load_and_authorize_resource

  def index
    @payment_choices = PaymentChoice.all
  end

  def new
    @payment_choice = PaymentChoice.new
  end

  def create
    @payment_choice = PaymentChoice.new(payment_choice_params)
    if @payment_choice.save
      flash[:success] = "Payment choice successfully created"
      redirect_to payment_choices_path
    else
      flash[:danger] = "Something went wrong"
      render 'new'
    end
  end

  def edit
    @payment_choice = PaymentChoice.find(params[:id])
  end

  def update
    if @payment_choice.update_attributes(payment_choice_params)
      flash[:success] = "Payment choice successfully updated"
      redirect_to payment_choices_path
    else
      flash[:danger] = "Something went wrong"
      render 'edit'
    end
  end

  private
    def payment_choice_params
      params.require(:payment_choice).permit(:name, :description, :fee, :fee_kind, :active)
    end
end
