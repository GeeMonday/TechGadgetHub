# app/admin/orders.rb
ActiveAdmin.register Order do
    index do
      selectable_column
      id_column
      column :customer
      column :total
      column :status
      actions
    end
  
    filter :customer
    filter :status
  
    form do |f|
      f.inputs do
        f.input :status, as: :select, collection: ['new', 'paid', 'shipped']
      end
      f.actions
    end
  end
  