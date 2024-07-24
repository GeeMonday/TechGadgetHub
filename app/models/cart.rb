class Cart < ApplicationRecord
    belongs_to :user
    has_many :cart_items, dependent: :destroy
    has_many :products, through: :cart_items
  
    validates :user_id, presence: true

  
    def total_price
      cart_items.includes(:product).sum('cart_items.quantity * products.price')
    end
    
    def self.ransackable_associations(auth_object = nil)
      %w[user cart_items products]
    end
  
    def self.ransackable_attributes(auth_object = nil)
      %w[id user_id created_at updated_at]
    end
  end
  