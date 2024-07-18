ActiveAdmin.register User do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :new_username, :password_digest, :email, :first_name, :last_name, :address_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:new_username, :password_digest, :email, :first_name, :last_name, :address_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  filter :new_username_cont, as: :string, label: 'Username'
end

