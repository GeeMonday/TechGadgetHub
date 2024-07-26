ActiveAdmin.register TaxRate do
  permit_params :province_id, :gst, :pst, :hst

  # Displaying tax rates in the index view
  index do
    selectable_column
    id_column
    column :province
    column :gst
    column :pst
    column :hst
    actions
  end

  # Form for creating/editing tax rates
  form do |f|
    f.inputs do
      f.input :province
      f.input :gst
      f.input :pst
      f.input :hst
    end
    f.actions
  end

  # Optional: Adding filters for searching
  filter :province
  filter :gst
  filter :pst
  filter :hst

  # Optional: Adding a scope or custom action
  # scope :all
end
