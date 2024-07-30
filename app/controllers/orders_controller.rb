class OrdersController < ApplicationController
  before_action :set_order, only: [:show]

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
    @cart = session[:cart] || {}
    @products = Product.find(@cart.keys)
  end

  def create
    @order = Order.new(order_params)
    @order.subtotal = @order.calculate_total
    @order.calculate_totals

    if @order.save
      add_cart_items_to_order
      session[:cart] = nil
      redirect_to order_path(@order), notice: 'Order was successfully created.'
    else
      flash[:alert] = "Order could not be created. Please try again."
      render :new
    end
  end

  def show
    @cart_items = @order.order_items.includes(:product)
  end

  private

  def set_order
    @order = Order.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Order not found."
    redirect_to root_path
  end

  def order_params
    params.require(:order).permit(:address_street, :address_city, :address_postal_code, :province_id, :status, order_items_attributes: [:id, :product_id, :quantity, :product_price, :_destroy])
  end

  def add_cart_items_to_order
    session[:cart].each do |product_id, quantity|
      product = Product.find(product_id)
      @order.order_items.create(product: product, quantity: quantity, product_price: product.sale_price || product.price)
    end
  end
end
