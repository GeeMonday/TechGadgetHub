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
      @order.save
  
      # Save customer information and order
      # Integrate payment gateway (e.g., Stripe or PayPal)
  
      session[:cart] = nil
      redirect_to order_path(@order)
    end
  
    private
  
    def order_params
      params.require(:order).permit(:customer_id, :address, :province, :total)
    end
  
    def calculate_total
      # Calculate total including taxes based on province
    end
  end
  