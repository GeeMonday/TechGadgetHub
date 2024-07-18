ActiveAdmin.register Category do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name
  #
  # or
  #
  # permit_params do
  #   permitted = [:name]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
    permit_params # Specify permitted parameters here if needed
  
    filter :name # Example filter for 'name'
  
    index do
      selectable_column
      id_column
      column :name
      column :products do |category|
        category.products.pluck(:name).join(', ')  # Example displaying associated products
      end
      actions
    end
  
    form do |f|
      f.inputs do
        f.input :name
        f.input :products, as: :check_boxes, collection: Product.all.map { |p| [p.name, p.id] }  # Adjust input type and collection as needed
      end
      f.actions
    end
  end
  
