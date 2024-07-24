class Product < ApplicationRecord
  has_many :product_categories
  has_many :categories, through: :product_categories
  has_many :cart_items
  has_and_belongs_to_many :categories
  has_many :carts, through: :cart_items
  has_one_attached :image

  validates :name, presence: true
  validates :description, presence: true
  validates :price, numericality: { greater_than: 0 }
  validates :stock, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  
  def image_url_or_default
    image.attached? ? url_for(image) : 'default_image.png'
  end
  
  def self.ransackable_associations(auth_object = nil)
    %w[categories cart_items carts]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id name price description created_at updated_at]
  end
end
