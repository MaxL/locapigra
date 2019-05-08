class SubscribersController < ApplicationController
  skip_authorization_check only: [:new, :create, :confirm_email]
  load_and_authorize_resource :except => [:new, :create, :confirm_email]
  before_action :set_subscriber, only: [:show, :edit, :update, :destroy, :unsubscribe, :subscribe]
  before_action :no_header

  def index
    @subscribers = Subscriber.all
  end

  def create
    @subscriber = Subscriber.new(subscriber_params)

    respond_to do |format|
      if @subscriber.save
        SubscriberMailer.registration_confirmation(@subscriber).deliver_later
        #format.html { redirect_to root_path, notice: 'Thanks for subscribing. Please confirm your subscription by clicking the link in the email we just sent you.' }
        format.js {}
        format.json { render json: {'message': 'Thanks for subscribing. Please confirm your subscription by clicking the link in the email we just sent you.'}, status: :created }
      else

        #format.html { redirect_to comics_path }
        format.js {}
        format.json { render json: @subscriber.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def confirm_email
    subscriber = Subscriber.find_by_confirmation_token(params[:token])
    if subscriber
      subscriber.email_activate
      subscriber.set_status true
      flash[:success] = "Thank you for subscribing, your email address has been confirmed."
      redirect_to root_path
    else
      flash[:danger] = "Subscription not found."
      redirect_to root_path
    end
  end

  def unsubscribe
    @subscriber.set_status false
    flash[:success] = "Subscriber unsubscribed"
    redirect_to subscribers_path
  end

  def subscribe
    @subscriber.set_status true
    flash[:success] = "Subscriber resubscribed"
    redirect_to subscribers_path
  end

  def destroy
    @subscriber.destroy
    flash[:success] = "Subscriber deleted"
    redirect_to subscribers_path
  end

  private
    def set_subscriber
      @subscriber = Subscriber.find(params[:id])
    end

    def subscriber_params
      params.require(:subscriber).permit(:name, :email)
    end
end
