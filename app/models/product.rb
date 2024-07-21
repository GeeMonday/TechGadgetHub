class Product < ApplicationRecord
  has_many :product_categories
  has_many :categories, through: :product_categories
  has_many :cart_items
  has_and_belongs_to_many :categories
  has_many :carts, through: :cart_items

  validates :name, presence: true
  validates :description, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :stock, numericality: { greater_than_or_equal_to: 0 }

  def self.ransackable_associations(auth_object = nil)
    %w[categories cart_items carts]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id name price description created_at updated_at]
  end
end
