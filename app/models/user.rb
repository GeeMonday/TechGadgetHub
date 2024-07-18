class User < ApplicationRecord
    has_secure_password
    has_many :carts
    belongs_to :address, optional: true
  
    validates :username, presence: true, uniqueness: true
    validates :email, presence: true, uniqueness: true
    validates :password_digest, presence: true
  
    def self.ransackable_associations(auth_object = nil)
      %w[address carts]
    end
  
    def self.ransackable_attributes(auth_object = nil)
      super + %w[new_username id email first_name last_name created_at updated_at]
    end
  end
  