ActiveAdmin.register User do
  permit_params :username, :email, :first_name, :last_name, :password, :password_confirmation, address_attributes: [:id, :street, :city, :province, :postal_code]

  # Display user details in the index view
  index do
    selectable_column
    id_column
    column :username
    column :email
    column :first_name
    column :last_name
    column :address_street, sortable: 'addresses.street' do |user|
      user.address.present? ? user.address.street : "No address"
    end
    column :address_city, sortable: 'addresses.city' do |user|
      user.address.present? ? user.address.city : "No address"
    end
    column :address_province, sortable: 'addresses.province' do |user|
      user.address.present? ? user.address.province : "No address"
    end
    column :address_postal_code, sortable: 'addresses.postal_code' do |user|
      user.address.present? ? user.address.postal_code : "No address"
    end
    column :encrypted_password do |user|
      user.encrypted_password
    end
    actions
  end

  form do |f|
    f.inputs 'User Details' do
      f.input :username
      f.input :email
      f.input :first_name
      f.input :last_name

      f.inputs 'Address' do
        f.fields_for :address, f.object.address || Address.new do |address_fields|
          address_fields.input :street
          address_fields.input :city
          address_fields.input :province
          address_fields.input :postal_code
        end
      end

      f.input :password, hint: 'Leave blank if you do not want to change the password'
      f.input :password_confirmation, hint: 'Leave blank if you do not want to change the password'
    end
    f.actions
  end

  controller do
    before_action :set_user, only: [:edit, :update]
    before_action :update_password, only: [:update]

    private

    def set_user
      @user = User.find(params[:id])
    end

    def update_password
      if params[:user][:password].blank?
        # Skip updating the password if it's not provided
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
    end
  end

  filter :username_cont, as: :string, label: 'Username'
end
