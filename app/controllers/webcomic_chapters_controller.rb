class WebcomicChaptersController < ApplicationController
  load_and_authorize_resource

  def index
    @chapters = WebcomicChapter.all
  end

  def new
    @chapter = WebcomicChapter.new
  end

  def create
    @chapter = WebcomicChapter.new(webcomic_chapter_params)
    if @chapter.save
      flash[:success] = "Chapter created"
      redirect_to @chapter
    else
      render 'new'
    end
  end

  def edit
    @chapter = WebcomicChapter.find(params[:id])
  end

  def update
    if @chapter.update_attributes
      flash[:success] = "Chapter updated"
      redirect_to @chapter
    else
      render 'edit'
    end
  end

  private
    def webcomic_chapter_params
        params.require(:webcomic_chapter).permit(:title, :chapter_number, :webcomic_id)
      end
end
