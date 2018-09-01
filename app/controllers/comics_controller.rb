class ComicsController < ApplicationController
  skip_authorization_check only: [:index, :show]
  load_and_authorize_resource :except => [:index, :show]
  #skip_authorize_resource :only => :index

  def index
    @released = Comic.where(released: true).paginate(page: params[:page]).order('position ASC')
    @unreleased = Comic.where(released: false).paginate(page: params[:page]).order('position ASC')
    @featured = Comic.where(featured: true).take
    @webcomics = Webcomic.all
    @token = DownloadToken.create(:expires_at => Time.now + 24.hours)
  end

  def show
    @comic = Comic.find(params[:id])
    @token = DownloadToken.create(:expires_at => Time.now + 24.hours)
    #debugger
  end

  def new
    @comic = Comic.new
  end

  def create
    @comic = Comic.new(comic_params)
    if @comic.save
      if params[:images]
        params[:images].each { |image| @comic.images.create(path: image) }
      end
      flash[:success] = "Comic successfully created"
      redirect_to @comic
    else
      render 'new'
    end
  end

  def edit
    @comic = Comic.find(params[:id])
  end

  def update
    @comic.slug = nil
    if @comic.update_attributes(comic_params)
      if params[:images]
        params[:images].each { |image| @comic.images.create(path: image) }
      end
      flash[:success] = "Comic successfully updated"
      redirect_to @comic
    else
      render 'edit'
    end
  end

  def destroy
    Comic.find(params[:id]).destroy
    flash[:success] = "Comic deleted"
    redirect_to comics_url
  end

  private
    def comic_params
      params.require(:comic).permit(:name, :description, :pages, :cover, :cover_image, :color, :dimensions, :images, :released, :product_id, :is_virtual, :pp_button, :featured, :position, :teaser, :title_image)
    end

    def token_params
      params.require(:download_token).permit(:token, :expires_at)
    end
end
