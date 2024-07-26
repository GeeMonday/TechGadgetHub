class Address < ApplicationRecord
    # Associations
    belongs_to :user
    belongs_to :province
  
    # Validations
    validates :street, :city, :province, :postal_code, :state, presence: true
    validates :postal_code, length: { is: 7 }, format: { with: /\A[A-Z]\d[A-Z] \d[A-Z]\d\z/, message: 'must be in the format A1A 1A1' } # Adjust format regex if needed

  
    # Ransackable attributes
    def self.ransackable_attributes(auth_object = nil)
      ["city", "created_at", "id", "postal_code", "province_id", "state", "street", "updated_at", "user_id"]
    end
  
    # Ensure these attributes are in your schema
    def self.ransackable_associations(auth_object = nil)
      ["province", "user"]
    end
  end
  