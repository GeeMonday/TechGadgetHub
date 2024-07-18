class Product < ApplicationRecord
    belongs_to :category
    has_and_belongs_to_many :categories
    has_many :cart_items
    has_many :carts, through: :cart_items
  
    validates :name, presence: true
    validates :price, presence: true, numericality: { greater_than: 0 }
  
    def self.ransackable_associations(auth_object = nil)
      %w[category cart_items carts]
    end
  
    def self.ransackable_attributes(auth_object = nil)
      %w[id name price description created_at updated_at]
    end
  end
  