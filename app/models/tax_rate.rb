# app/models/tax_rate.rb
class TaxRate < ApplicationRecord
    belongs_to :province
  
    validates :province_id, presence: true
    validates :gst, :pst, :hst, numericality: { greater_than_or_equal_to: 0 }
  end
  