class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :product

  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :product_price, presence: true, numericality: { greater_than: 0 }

  before_save :set_product_price

  def total_price
    product_price * quantity
  end

  private

  def set_product_price
    self.product_price = product.sale_price || product.price
  end
end
