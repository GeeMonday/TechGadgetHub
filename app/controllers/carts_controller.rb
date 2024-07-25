class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart
    if @cart
      @cart_items = @cart.cart_items.includes(:product)
      @cart_total = @cart.cart_items.sum { |item| item.product.price * item.quantity }
    else
      @cart_items = []
      @cart_total = 0
    end
  end

  def add_to_cart
    @cart = current_user.cart
    if @cart.nil?
      @cart = Cart.create(user: current_user)  # Create a new cart if none exists
    end

    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    # Find existing cart item or create a new one
    item = @cart.cart_items.find_or_initialize_by(product: product)
    item.quantity = quantity
    item.save

    redirect_to cart_path, notice: 'Product added to cart.'
  end

  def update
    @cart = current_user.cart
    if @cart
      cart_item_id = params[:cart_item_id]
      new_quantity = params[:quantity].to_i

      item = @cart.cart_items.find(cart_item_id)
      if item
        item.update(quantity: new_quantity)
      end
    end

    redirect_to cart_path
  end

  def remove
    @cart = current_user.cart
    if @cart
      cart_item_id = params[:id]  # Use params[:id] for removing specific item

      item = @cart.cart_items.find(cart_item_id)
      if item
        item.destroy
      end
    end

    redirect_to cart_path
  end

  def checkout
    @order = Order.new
  end

  def complete_checkout
    @order = Order.new(order_params)
    if @order.save
      current_user.cart.cart_items.destroy_all  # Clear the cart after successful checkout
      redirect_to order_confirmation_path(@order), notice: 'Checkout completed successfully.'
    else
      render :checkout
    end
  end

  private

  def order_params
    params.require(:order).permit(:address, :province, :payment_method, :total_price)
  end
end
