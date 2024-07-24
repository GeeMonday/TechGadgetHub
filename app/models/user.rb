class User < ApplicationRecord
  # Include default devise modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Associations
  has_one :cart, dependent: :destroy
  belongs_to :address, optional: true

  # Validations
  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  # Callbacks
  after_create :create_cart

  # Ransackable associations and attributes
  def self.ransackable_associations(auth_object = nil)
    %w[address cart]
  end

  def self.ransackable_attributes(auth_object = nil)
    super + %w[username id email first_name last_name created_at updated_at]
  end

  private

  def create_cart
    Cart.create(user: self) if self.cart.nil?
  end
end
