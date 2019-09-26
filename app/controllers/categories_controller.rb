class CategoriesController < ApplicationController
  skip_authorization_check only: [:index, :show]
  load_and_authorize_resource :except => [:index, :show]

  def index
    @categories = Category.all
  end

  def show
    @category = Category.friendly.find(params[:id])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category created"
      redirect_to 'index'
    else
      render 'new'
    end
  end

  def edit
    @category = Category.find(params[:id])
  end

  def update
    @category.slug = nil
    @category = Category.find(params[:id])

    if @category.update_attributes(category_params)
      flash[:success] = 'Category updated'
      redirect_to @category
    else
      render 'edit'
    end
  end

  def destroy
    Category.find(params[:id]).destroy
    flash[:success] = 'Category deleted'
    redirect_to products_url
  end

  private

    def category_params
      params.require(:category).permit(:title, :description)
    end

end
