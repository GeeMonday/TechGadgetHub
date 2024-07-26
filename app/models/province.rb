class Province < ApplicationRecord
  has_many :addresses
  has_many :orders
  has_many :tax_rates
  has_one :tax_rate, dependent: :destroy

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
end
