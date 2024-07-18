class Order < ApplicationRecord
    belongs_to :user
    has_one :shipment
    has_many :order_items
    has_many :products, through: :order_items
  
    validates :user_id, presence: true
    validates :status, presence: true
    validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  end
  