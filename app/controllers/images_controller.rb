class ImagesController < ApplicationController

  def create
    @image = Image.new(image_params)
    @image.save
  end

  def destroy
    Image.find(params[:id]).destroy
    flash[:success] = "Image deleted"
  end

  private
    def image_params
      params.require(:image).permit(:path, :remove_path)
    end
end
