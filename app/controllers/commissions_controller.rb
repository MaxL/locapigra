class CommissionsController < ApplicationController
  skip_authorization_check only: [:show, :index, :create_message]
  load_and_authorize_resource :except => [:show, :index, :create_message]
  before_action :set_commission, only: [:show, :edit, :update, :destroy]

  # GET /commissions
  # GET /commissions.json
  def index
    @commissions = Commission.all
    @message = Message.new
  end

  # GET /commissions/1
  # GET /commissions/1.json
  def show
  end

  # GET /commissions/new
  def new
    @commission = Commission.new
  end

  # GET /commissions/1/edit
  def edit
  end

  # POST /commissions
  # POST /commissions.json
  def create
    @commission = Commission.new(commission_params)
    respond_to do |format|
      if @commission.save
        if params[:commission_images]
          params[:commission_images].each { |commission_image| @commission.commission_images.create(path: commission_image) }
        end
        format.html { redirect_to @commission, notice: 'Commission was successfully created.' }
        format.json { render :show, status: :created, location: @commission }
      else
        format.html { render :new }
        format.json { render json: @commission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /commissions/1
  # PATCH/PUT /commissions/1.json
  def update
    #@commission.slug = nil
    if @commission.update_attributes(commission_params)
      if params[:commission_images]
        params[:commission_images].each { |commission_image| @commission.commission_images.create(path: commission_image) }
      end
      flash[:success] = "Commission successfully updated"
      redirect_to @commission
    else
      render :edit
    end
  end

  # DELETE /commissions/1
  # DELETE /commissions/1.json
  def destroy
    @commission.destroy
    respond_to do |format|
      format.html { redirect_to commissions_url, notice: 'Commission was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def create_message
    @message = Message.new message_params
    if @message.valid?
      MessageMailer.contact(@message.to_json).deliver_later
      redirect_to commissions_path
      flash[:success] = "Your message was successfully sent, we'll be in touch soon!"
    else
      flash[:notice] = "There was an error sending your message. Please try again."
      render :new
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_commission
      @commission = Commission.find(params[:id])
      @commission_images = @commission.commission_images.order('position')
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def commission_params
      params.require(:commission).permit(:title, :description, :commission_images)
    end

    def message_params
      params.require(:message).permit(:name, :email, :body)
    end
end
