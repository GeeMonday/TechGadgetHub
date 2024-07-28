class Address < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :province

  # Validations
  validates :street, :city, :province, :postal_code, :state, presence: true
  validates :postal_code, length: { is: 7 }, format: { with: /\A[A-Z]\d[A-Z] \d[A-Z]\d\z/, message: 'must be in the format A1A 1A1' }

  # Ransackable attributes
  def self.ransackable_attributes(auth_object = nil)
    %w[street city postal_code province_id state]
  end

  # Ransackable associations
  def self.ransackable_associations(auth_object = nil)
    %w[province user]
  end
end
