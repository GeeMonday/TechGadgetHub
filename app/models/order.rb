class Order < ApplicationRecord
  belongs_to :user
  has_one :address, through: :user
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items, allow_destroy: true

  validates :user, presence: true
  validates :status, presence: true
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :subtotal, :gst, :pst, :hst, presence: true, numericality: { greater_than_or_equal_to: 0 }

  before_validation :set_defaults

  def total_price
    # Calculate total price based on order_items
    order_items.sum(&:price) # Ensure `OrderItem` has a `price` attribute
  end

  def self.ransackable_associations(auth_object = nil)
    ["address", "order_items", "province", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    super + ["subtotal", "gst", "pst", "hst", "total_price", "status"]
  end

  private

  def set_defaults
    self.status ||= 'pending'
    self.total_price ||= 0
  end
end
