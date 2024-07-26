# app/models/order.rb
class Order < ApplicationRecord
  belongs_to :user
  has_many :order_items, dependent: :destroy

  validates :user, presence: true
  validates :status, presence: true
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :subtotal, :gst, :pst, :hst, presence: true

  before_validation :set_defaults

  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "gst", "hst", "id", "payment_method", "province", "pst", "status", "subtotal", "total_price", "updated_at", "user_id"]
  end

  private

  def set_defaults
    self.status ||= 'pending'
    self.total_price ||= 0
  end
end
