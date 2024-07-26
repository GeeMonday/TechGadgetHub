# app/models/order_item.rb
class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  # Add any necessary validations here
  validates :quantity, :price, presence: true
end
