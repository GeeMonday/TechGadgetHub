class Order < ApplicationRecord
  belongs_to :user
  has_one :address, through: :user
  has_many :order_items, dependent: :destroy
  accepts_nested_attributes_for :order_items, allow_destroy: true

  validates :user, presence: true
  validates :status, presence: true
  validates :total_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :subtotal, :gst, :pst, :hst, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :stripe_charge_id, presence: true, if: :paid?

  before_validation :set_defaults, on: :create

  def subtotal
    order_items.sum { |item| (item.product.sale_price || item.product.price) * item.quantity }
  end

  def calculate_tax(tax_type)
    tax_rate = TaxRate.find_by(province_id: province_id) # Use the province_id directly
    tax_rate ? subtotal * (tax_rate.send(tax_type) / 100.0) : 0
  end

  def calculate_totals
    self.gst = calculate_tax(:gst)
    self.pst = calculate_tax(:pst)
    self.hst = calculate_tax(:hst)
    self.total_price = subtotal + gst + pst + hst
  end

  def total_price_in_cents
    (total_price * 100).to_i
  end

  private

  def set_defaults
    self.status ||= 'pending'
    self.total_price ||= 0
    self.gst ||= 0
    self.pst ||= 0
    self.hst ||= 0
  end

  def paid?
    status == 'paid'
  end

  def self.ransackable_associations(auth_object = nil)
    ["address", "order_items", "user"]
  end

  def self.ransackable_attributes(auth_object = nil)
    %w[id user_id created_at updated_at status total_price subtotal gst pst hst address_street address_city address_postal_code province_name]
  end
end
