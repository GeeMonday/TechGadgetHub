ActiveAdmin.register Product do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :description, :price, :stock
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :description, :price, :stock]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  permit_params :name, :description, :price, :stock  # Uncomment and specify permitted parameters for assignment
  
  filter :name  # Example of adding a basic filter for 'name'
  filter :price  # Example of adding a basic filter for 'price'

  index do
    selectable_column
    id_column
    column :name
    column :description
    column :price
    column :stock
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :price
      f.input :stock
    end
    f.actions
  end
end
