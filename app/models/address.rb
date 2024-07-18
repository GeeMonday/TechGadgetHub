class Address < ApplicationRecord
    belongs_to :user
  
    validates :address_line1, presence: true
    validates :city, presence: true
    validates :state, presence: true
    validates :postal_code, presence: true

    def self.ransackable_attributes(auth_object = nil)
        ["city", "country", "created_at", "id", "id_value", "postal_code", "province_id", "street", "updated_at", "user_id"]
      end
  end
  