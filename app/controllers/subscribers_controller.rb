class SubscribersController < ApplicationController
  skip_authorization_check only: [:new, :create]
  load_and_authorize_resource :except => [:new, :create]
  before_action :set_subscriber, only: [:show, :edit, :update, :destroy]

  def index
    @subscribers = Subscriber.all
  end

  def create
    @subscriber = Subscriber.new(subscriber_params)
    respond_to do |format|
      if @subscriber.save
        SubscriberMailer.registration_confirmation(@subscriber).deliver_later
        format.html { redirect_to root_path, notice: 'Thanks for subscribing. Please confirm your subscription by clicking the link in the email we just sent you.' }
        #format.json { render json: 'Thanks for subscribing. Please confirm your subscription by clicking the link in the email we just sent you.', status: :created }
      else
        format.html { redirect_to comics_path }
        format.json { render json: @commission.errors, status: :unprocessable_entity }
      end
    end
  end

  def confirm_email
    subscriber = Subscriber.find_by_confirmation_token(params[:id])
    if subscriber
      subscriber.email_activate
      flash[:success] = "Thank you for subscribing, your email address has been confirmed."
      redirect_to root_path
    else
      flash[:danger] = "Subscription not found."
      redirect_to root_path
    end
  end

  private
    def set_subscriber
      @subscriber = Subscriber.find(params[:id])
    end

    def subscriber_params
      params.require(:subscriber).permit(:name, :email)
    end
end
