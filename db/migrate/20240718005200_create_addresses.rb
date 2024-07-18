class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.integer :user_id
      t.integer :province_id
      t.string :street
      t.string :city
      t.string :postal_code
      t.string :country
      t.timestamps
    end
  end
end
