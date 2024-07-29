ActiveAdmin.register User do
  permit_params :username, :email, :first_name, :last_name, :password, :password_confirmation, address_attributes: [:id, :street, :city, :province, :postal_code, :_destroy]

  index do
    selectable_column
    id_column
    column :username
    column :email
    column :first_name
    column :last_name
    column :address_street do |user|
      user.address.present? ? user.address.street : "No address"
    end
    column :address_city do |user|
      user.address.present? ? user.address.city : "No address"
    end
    column :address_province do |user|
      user.address.present? ? user.address.province : "No address"
    end
    column :address_postal_code do |user|
      user.address.present? ? user.address.postal_code : "No address"
    end
    column :encrypted_password do |user|
      user.encrypted_password
    end
    column 'Past Orders' do |user|
      link_to 'View Orders', admin_orders_path(q: { user_id_eq: user.id })
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
        f.semantic_fields_for :address, f.object.address || Address.new do |address_fields|
          address_fields.input :street, label: 'Street'
          address_fields.input :city, label: 'City'
          address_fields.input :province, label: 'Province'
          address_fields.input :postal_code, label: 'Postal Code'
        end
      end

      f.input :password, hint: 'Leave blank if you do not want to change the password'
      f.input :password_confirmation, hint: 'Leave blank if you do not want to change the password'
    end
    f.actions
  end

  controller do
    def update
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
      super
    end

    def create
      @user = User.new(permitted_params[:user])
      if @user.save
        redirect_to admin_user_path(@user), notice: "User was successfully created."
      else
        render :new
      end
    end

    private

    def permitted_params
      params.permit(user: [:username, :email, :first_name, :last_name, :password, :password_confirmation, address_attributes: [:id, :street, :city, :province, :postal_code, :_destroy]])
    end
  end

  filter :username_cont, as: :string, label: 'Username'
end
