class ProductsController < ApplicationController
  skip_authorization_check only: [:index, :show]
  load_and_authorize_resource :except => [:index, :show]

  def index
    @products = Product.paginate(page: params[:page])
    @order_item = current_order.order_items.new
  end

  def admin_index
    @products = Product.all
  end

  def show
    @product = Product.friendly.find(params[:id])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      flash[:success] = "Product created"
      redirect_to @product
    else
      render 'new'
    end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    @product.slug = nil
    @product = Product.find(params[:id])

    if @product.update_attributes(product_params)
      flash[:success] = 'Product updated'
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    Product.find(params[:id]).destroy
    flash[:success] = 'Product deleted'
    redirect_to products_url
  end

  private

    def product_params
      params.require(:product).permit(:name, :description, :price, :taxrate, :weight, :meta_title, :meta_description, :quantity, :package, :cover_image, :release_date, :language, :active)
    end

end
