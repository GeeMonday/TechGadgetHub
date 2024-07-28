# app/controllers/orders_controller.rb
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
    @order.total = calculate_total

    if @order.save
      # Add cart_items to the order
      add_cart_items_to_order

      session[:cart] = nil
      redirect_to order_path(@order), notice: 'Order was successfully created.'
    else
      flash[:alert] = "Order could not be created. Please try again."
      render :new
    end
  end

  def show
    # @order is set by the before_action :set_order
    # Ensure that cart_items and associated products are included
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
    params.require(:order).permit(:address_street, :address_city, :address_zip_code, :province_id)
  end

  def calculate_total
    subtotal = @order.cart_items.sum { |item| item.quantity * item.product.price }
    tax_rate = TaxRate.find_by(province_id: @order.province_id)
    tax = (subtotal * (tax_rate.gst + tax_rate.pst + tax_rate.hst) / 100)
    total = subtotal + tax
    total
  end

  def add_cart_items_to_order
    session[:cart].each do |product_id, quantity|
      product = Product.find(product_id)
      @order.cart_items.create(product: product, quantity: quantity)
    end
  end
end
