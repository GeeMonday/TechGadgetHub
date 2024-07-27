# app/admin/customer_orders.rb
ActiveAdmin.register_page "Customer Orders" do
    content do
      panel "All Customers and Their Orders" do
        table_for User.includes(:orders) do
          column "Customer" do |user|
            user.username
          end
          column "Email" do |user|
            user.email
          end
          column "Orders" do |user|
            user.orders.map do |order|
              "<strong>Order ##{order.id}</strong>: " +
              "Subtotal: #{number_to_currency(order.subtotal)}, " +
              "Taxes: #{number_to_currency(order.gst + order.pst + order.hst)}, " +
              "Total: #{number_to_currency(order.total_price)}"
            end.join("<br>").html_safe
          end
        end
      end
    end
  end
  