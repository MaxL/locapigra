class ComicsController < ApplicationController
  load_and_authorize_resource :except => [:index, :show]
  #skip_authorize_resource :only => :index

  def index
    @comics = Comic.paginate(page: params[:page])
  end

  def show
    @comic = Comic.find(params[:id])
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
    @comic = Comic.find(params[:id])

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
      params.require(:comic).permit(:name, :description, :pages, :cover, :cover_image, :color, :dimensions, :images)
    end
end
