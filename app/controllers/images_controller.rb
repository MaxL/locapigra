class ImagesController < ApplicationController
  before_action require_login

  def create
    @image = Image.new(image_params)
    @image.save
  end

  private
    def image_params
      params.require(:image).premit(:path)
    end
end
