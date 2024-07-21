class ProductsController < ApplicationController
  def index
    # Initialize ransack search
    @q = Product.joins(:categories).ransack(params[:q])
    @products = @q.result(distinct: true)

    # Apply additional filters based on query parameters
    if params[:on_sale]
      @products = @products.where(on_sale: true)
    end

    if params[:new]
      @products = @products.where('created_at >= ?', 3.days.ago)
    end

    if params[:recently_updated]
      @products = @products.where('updated_at >= ?', 3.days.ago)
    end

    # Paginate the results
    @products = @products.page(params[:page]).per(10)

    # Fetch featured products
    @featured_products = Product.limit(10)
  end

  def show
    @product = Product.find(params[:id])
  end
end
