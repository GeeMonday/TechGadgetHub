# app/controllers/orders_controller.rb
class OrdersController < ApplicationController
  def new
    @order = Order.new
    @cart = session[:cart] || {}
    @products = Product.find(@cart.keys)
  end

  def create
    @order = Order.new(order_params)
    @order.total = calculate_total

    if @order.save
      # Additional logic for saving customer information and integrating payment gateway
      session[:cart] = nil
      redirect_to order_path(@order), notice: 'Order was successfully created.'
    else
      # Handle errors in order creation
      flash[:alert] = "Order could not be created. Please try again."
      render :new
    end
  end

  def show
    @order = Order.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:alert] = "Order not found."
    redirect_to root_path
  end

  private

  def order_params
    params.require(:order).permit(:address_street, :address_city, :address_state, :address_zip_code)
  end


  def calculate_total
    # Implement the logic to calculate the total including taxes based on province
    # This method should return the total price after all calculations
  end
end
 