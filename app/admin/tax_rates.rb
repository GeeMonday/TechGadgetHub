# app/admin/tax_rates.rb
ActiveAdmin.register TaxRate do
    permit_params :province_id, :gst, :pst, :hst
  
    form do |f|
      f.inputs do
        f.input :province
        f.input :gst
        f.input :pst
        f.input :hst
      end
      f.actions
    end
  end
  