class Users::SessionsController < Devise::SessionsController
  skip_authorization_check only: [:create, :destroy]
  before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    puts 'LOGIN puts'
    super
    current_or_guest_user
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  def my_orders
    @user = current_user
    @orders = @user.orders.all
  end

  protected

    # If you have extra params to permit, append them to the sanitizer.
    def configure_sign_in_params
      devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
    end
end
