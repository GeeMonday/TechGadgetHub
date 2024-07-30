class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart || Cart.create(user: current_user)
    @cart_items = @cart.cart_items.includes(:product)
    @cart_total = @cart.calculate_total
  end

  def add_to_cart
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    if current_user.cart
      current_user.cart.add_product(product, quantity)
      flash[:notice] = 'Product added to cart!'
    else
      flash[:alert] = 'Failed to add product to cart.'
    end

    redirect_to product_path(product)
  end

  def update
    @cart = current_user.cart
    if @cart
      cart_item_id = params[:cart_item_id]
      new_quantity = params[:quantity].to_i

      item = @cart.cart_items.find_by(id: cart_item_id)
      if item
        item.update(quantity: new_quantity) if new_quantity.positive?
      else
        flash[:alert] = 'Item not found in cart.'
      end
    else
      flash[:alert] = 'Cart not found.'
    end

    redirect_to cart_path
  end

  def remove
    @cart = current_user.cart
    if @cart
      cart_item_id = params[:id]

      item = @cart.cart_items.find_by(id: cart_item_id)
      if item
        item.destroy
        flash[:notice] = 'Item removed from cart.'
      else
        flash[:alert] = 'Item not found in cart.'
      end
    else
      flash[:alert] = 'Cart not found.'
    end

    redirect_to cart_path
  end

  def checkout
    @cart = current_user.cart
    if @cart
      @order = Order.new(
        address_street: current_user.address.street,
        address_city: current_user.address.city,
        address_postal_code: current_user.address.postal_code,
        province_id: current_user.address.province_id,
        total_price: @cart.calculate_total
      )
      @cart_items = @cart.cart_items.includes(:product)
      @cart_total = @cart.calculate_total
    else
      flash[:alert] = 'Cart not found.'
      redirect_to root_path
    end
  end

  def complete_checkout
    @order = Order.new(order_params)
    @order.user = current_user
    @order.status = 'pending'

    if current_user.cart && current_user.cart.cart_items.present?
      cart_total = current_user.cart.calculate_total
      province = Province.find(order_params[:province_id])
      tax_details = TaxCalculator.calculate_total_price(cart_total, province)

      @order.subtotal = cart_total
      @order.gst = tax_details[:gst]
      @order.pst = tax_details[:pst]
      @order.hst = tax_details[:hst]
      @order.total_price = tax_details[:total_price]

      if @order.save
        redirect_to order_path(@order)
      else
        flash[:alert] = "Order could not be processed. Errors: #{@order.errors.full_messages.join(', ')}"
        render :checkout
      end
    else
      flash[:alert] = "Your cart is empty or not found."
      redirect_to cart_path
    end
  end

  private

  def order_params
    params.require(:order).permit(:address_street, :address_city, :address_postal_code, :province_id, :payment_method)
  end
end
