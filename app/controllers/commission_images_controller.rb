class CommissionImagesController < ApplicationController
  load_and_authorize_resource

  def show
    @image = CommissionImage.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @image = CommissionImage.new
  end

  def create
    @image = CommissionImage.new(commision_image_params)
    if @image.save
      flash[:success] = "Commission Image Created"
      redirect_to @image
    else
      render 'new'
    end
  end

  def edit
    @commision_image = CommissionImage.find(params[:id])
  end

  def update
    if @commision_image.update_attributes(commision_image_params)
      flash[:success] = "Image updated"
      redirect_to @commision_image
    else
      render 'edit'
    end
  end

  def sort
    params[:commision_image].each_with_index do |id, index|
      CommissionImage.where(id: id).update_all(image_number: index + 1)
    end

    head :ok
  end

  def destroy
    CommissionImage.find(params[:id]).destroy
    flash[:success] = "Image deleted"
    redirect_to commissions_url
  end

  private
    def commision_image_params
      params.require(:commission_image).permit(:path, :position, :commission_id)
    end
end
