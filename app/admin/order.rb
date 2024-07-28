ActiveAdmin.register Order do
  index do
    selectable_column
    id_column
    column :user
    column 'Street' do |order|
      order.address&.street
    end
    column 'City' do |order|
      order.address&.city
    end
    column 'Postal Code' do |order|
      order.address&.postal_code
    end
    column 'Province' do |order|
      order.address&.province&.name
    end
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

  # Custom Ransack filter configuration
  filter :user, as: :select, collection: -> { User.pluck(:username, :id) }
  filter :address_street, as: :string, label: 'Street'
  filter :address_city, as: :string, label: 'City'
  filter :address_postal_code, as: :string, label: 'Postal Code'
  filter :address_province_id, as: :select, collection: -> { Province.pluck(:name, :id) }, label: 'Province'
  filter :status
  filter :subtotal
  filter :total_price
  filter :created_at

  form do |f|
    f.inputs 'Order Details' do
      f.input :status
      f.input :subtotal
      f.input :gst
      f.input :pst
      f.input :hst
      f.input :total_price
    end

    f.inputs 'Address Details' do
      f.input :address_street, label: 'Street'
      f.input :address_city, label: 'City'
      f.input :address_postal_code, label: 'Postal Code'
      f.input :province_id, as: :select, collection: Province.all.map { |p| [p.name, p.id] }, label: 'Province'
    end

    f.inputs 'Order Items' do
      f.has_many :order_items, allow_destroy: true, new_record: true do |oi|
        oi.input :product
        oi.input :quantity
        oi.input :price, as: :number, min: 0
      end
    end

    f.actions
  end

  show do
    attributes_table do
      row :id
      row :status
      row :subtotal
      row :gst
      row :pst
      row :hst
      row :total_price
      row :created_at
      row :updated_at
      row 'Street' do
        order.address&.street
      end
      row 'City' do
        order.address&.city
      end
      row 'Postal Code' do
        order.address&.postal_code
      end
      row 'Province' do
        order.address&.province&.name
      end
      row 'Customer' do
        link_to order.user.username, admin_user_path(order.user) if order.user
      end
    end

    panel 'Order Items' do
      table_for order.order_items do
        column 'Product' do |item|
          link_to item.product.name, admin_product_path(item.product)
        end
        column 'Quantity' do |item|
          item.quantity
        end
        column 'Price' do |item|
          number_to_currency(item.price)
        end
        column 'Total' do |item|
          number_to_currency(item.price * item.quantity)
        end
      end
    end
  end

  permit_params :status, :subtotal, :gst, :pst, :hst, :total_price, :address_street, :address_city, :address_postal_code, :province_id,
                order_items_attributes: [:id, :product_id, :quantity, :price, :_destroy]
end
