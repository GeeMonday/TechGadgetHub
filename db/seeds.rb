# db/seeds.rb

addresses = [
  { user_id: 1, street: '123 Elm St', city: 'Toronto', postal_code: 'M5A 1A1', state: 'ON', province_code: 'ON' },
  { user_id: 2, street: '456 Maple Ave', city: 'Vancouver', postal_code: 'V6B 2B2', state: 'BC', province_code: 'BC' },
  { user_id: 3, street: '789 Oak Dr', city: 'Montreal', postal_code: 'H1A 1A1', state: 'QC', province_code: 'QC' },
  { user_id: 4, street: '321 Pine St', city: 'Calgary', postal_code: 'T2P 1A1', state: 'AB', province_code: 'AB' },
  { user_id: 5, street: '654 Birch Rd', city: 'Halifax', postal_code: 'B3J 1A1', state: 'NS', province_code: 'NS' }
]

addresses.each do |address|
  user = User.find_by(id: address[:user_id])
  
  if user
    province = Province.find_by(code: address[:province_code])
    
    if province
      user.build_address(
        street: address[:street],
        city: address[:city],
        postal_code: address[:postal_code],
        state: address[:state],
        province: province
      )
      
      if user.save
        puts "Address updated successfully for user #{user.id}"
      else
        puts "Failed to update address for user #{user.id}: #{user.errors.full_messages.join(', ')}"
      end
    else
      puts "Province with code #{address[:province_code]} not found for user #{user.id}"
    end
  else
    puts "User with ID #{address[:user_id]} not found"
  end
end
