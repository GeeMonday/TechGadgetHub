class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update]

  def index
    @orders = current_user.orders
  end

  def new
    @order = Order.new
    @cart = current_user.cart
    @products = @cart.cart_items.includes(:product).map(&:product) if @cart
  end

  def create
    @order = Order.new(order_params)
    @order.user = current_user
    @order.status = 'Pending' # Set default status
    @order.calculate_total # Calculate total before saving

    if @order.save
      add_cart_items_to_order
      current_user.cart.cart_items.destroy_all # Clear the cart
      redirect_to @order, notice: 'Order was successfully created.'
    else
      flash[:alert] = 'Order could not be created. Please try again.'
      render :new
    end
  end

  def show
    @cart_items = @order.order_items.includes(:product)
  end

  def update
    if @order.update(order_params)
      redirect_to @order, notice: 'Order was successfully updated.'
    else
      flash[:alert] = 'Order could not be updated. Please try again.'
      render :edit
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = 'Order not found.'
    redirect_to root_path
  end

  def order_params
    params.require(:order).permit(
      :address_street, :address_city, :address_postal_code, :province_id,
      :status, :subtotal, :gst, :pst, :hst, :total_price,
      order_items_attributes: [:id, :product_id, :quantity, :price, :_destroy]
    )
  end

  def add_cart_items_to_order
    current_user.cart.cart_items.each do |item|
      @order.order_items.create(
        product: item.product,
        quantity: item.quantity,
        price: item.product.price
      )
    end
  end
end
