class Province < ApplicationRecord
    has_many :addresses
    has_many :orders
  
    validates :name, presence: true, uniqueness: true
    validates :code, presence: true, uniqueness: true
  end
  