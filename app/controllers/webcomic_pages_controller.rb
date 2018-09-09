class WebcomicPagesController < ApplicationController
  load_and_authorize_resource

  def show
    @page = WebcomicPage.find(params[:id])
    respond_to do |format|
      format.html
      format.js
    end
  end

  def new
    @page = WebcomicPage.new
  end

  def create
    @page = WebcomicPage.new(webcomic_page_params)
    if @page.save
      flash[:success] = "Webcomic Page Created"
      redirect_to @page
    else
      render 'new'
    end
  end

  def edit
    @webcomic_page = WebcomicPage.find(params[:id])
    puts 'webcomic:'
    puts @webcomic_page.webcomic
    puts '============'
    @available_chapters = WebcomicChapter.where(webcomic_id: @webcomic_page.webcomic.id).collect {|w| [ w.title, w.id ] }
  end

  def update
    if @webcomic_page.update_attributes(webcomic_page_params)
      flash[:success] = "Page updated"
      redirect_to @webcomic_page
    else
      render 'edit'
    end
  end

  def sort
    params[:webcomic_page].each_with_index do |id, index|
      WebcomicPage.where(id: id).update_all(page_number: index + 1)
    end

    head :ok
  end

  def destroy
    WebcomicPage.find(params[:id]).destroy
    flash[:success] = "Page deleted"
    redirect_to comics_url
  end

  private
    def webcomic_page_params
      params.require(:webcomic_page).permit(:path, :page_number, :webcomic_chapter_id, :webcomic_id)
    end
end
