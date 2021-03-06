class WebcomicsController < ApplicationController
  skip_authorization_check only: [:show]
  load_and_authorize_resource :except => [:show]

  def index
    @webcomics = Webcomic.all
  end

  def show
    @webcomic = Webcomic.find(params[:id])
    @webcomic_pages = @webcomic.webcomic_pages.paginate(:page => params[:page], :per_page => 1).order('page_number')#.order('created_at ASC')
    @pages = @webcomic.webcomic_pages.order('page_number')
    @chapters = @webcomic.webcomic_chapters
    @subscriber = Subscriber.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def all
    @pages = @webcomic.webcomic_pages.order('page_number')
    respond_to do |format|
      format.js
    end
  end

  def new
    @webcomic = Webcomic.new
  end

  def create
    @webcomic = Webcomic.new(webcomic_params)
    if @webcomic.save
      if params[:webcomic_pages]
        params[:webcomic_pages].each { |webcomic_page| @webcomic.webcomic_pages.create(path: webcomic_page) }
      end
      flash[:success] = "Webcomic successfully created"
      redirect_to @webcomic
    else
      render 'new'
    end
  end

  def edit
    @webcomic = Webcomic.find(params[:id])
    @webcomic_pages = @webcomic.webcomic_pages.order('page_number')
  end

  def update
    @webcomic.slug = nil
    if @webcomic.update_attributes(webcomic_params)
      if params[:webcomic_pages]
        params[:webcomic_pages].each { |webcomic_page| @webcomic.webcomic_pages.create(path: webcomic_page) }
      end
      flash[:success] = "Webcomic successfully updated"
      redirect_to @webcomic
    else
      render 'edit'
    end
  end

  private

    def webcomic_params
      params.require(:webcomic).permit(:title, :description, :webcomic_pages, :title_image)
    end
end
