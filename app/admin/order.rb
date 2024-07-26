# app/admin/orders.rb
ActiveAdmin.register Order do
  # Define the columns to be displayed in the index view
  index do
    selectable_column
    id_column
    column :address
    column :status
    column :subtotal
    column :gst
    column :pst
    column :hst
    column :total_price
    column :created_at
    column :updated_at
    actions
  end

  # Define filters (optional)
  filter :address
  filter :status
  filter :subtotal
  filter :total_price
  filter :created_at
end
