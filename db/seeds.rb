# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

#StaticPage.create!(title: 'Contact', content: 'Initial contact content')
#StaticPage.create!(title: 'About', content: 'Initial about content')

# Seed categories
categories = ['Smartphones', 'Laptops', 'Smart Home Devices', 'Gaming Consoles']

categories.each do |category_name|
  Category.find_or_create_by(name: category_name)
end

# Verify categories creation
Category.all.each do |category|
    puts "Category created: #{category.name} with ID: #{category.id}"
  end

# Seed products with stock information
products_data = [
  { name: 'iPhone 13 Pro', description: 'The latest iPhone with advanced camera and performance.', price: 999.99, category_name: 'Smartphones', stock: 50, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'MacBook Pro 2023', description: 'Powerful laptop for professionals with new M2 chip.', price: 1999.99, category_name: 'Laptops', stock: 30, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Nest Thermostat', description: 'Smart thermostat with energy-saving features.', price: 199.99, category_name: 'Smart Home Devices', stock: 40, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'PlayStation 5', description: 'Next-gen gaming console with ultra-fast SSD.', price: 499.99, category_name: 'Gaming Consoles', stock: 20, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Samsung Galaxy S22 Ultra', description: 'Flagship smartphone with a powerful camera system and 5G support.', price: 1199.99, category_name: 'Smartphones', stock: 25, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Dell XPS 15', description: 'High-performance laptop with stunning 4K display and powerful CPU.', price: 1799.99, category_name: 'Laptops', stock: 35, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Google Nest Hub Max', description: 'Smart display with built-in Google Assistant for smart home control.', price: 229.99, category_name: 'Smart Home Devices', stock: 45, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Xbox Series X', description: 'Microsoft\'s latest gaming console with 4K gaming support and SSD storage.', price: 599.99, category_name: 'Gaming Consoles', stock: 15, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'OnePlus 10 Pro', description: 'Premium Android smartphone with Hasselblad camera technology.', price: 899.99, category_name: 'Smartphones', stock: 28, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'HP Spectre x360', description: 'Convertible laptop with OLED display and powerful Intel processor.', price: 1499.99, category_name: 'Laptops', stock: 32, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Amazon Echo Show 15', description: 'Large screen smart display for home entertainment and video calling.', price: 249.99, category_name: 'Smart Home Devices', stock: 38, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Nintendo Switch OLED', description: 'Updated version of Nintendo\'s popular console with OLED screen.', price: 349.99, category_name: 'Gaming Consoles', stock: 18, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Google Pixel 6', description: 'Google\'s flagship phone with enhanced camera features and 5G support.', price: 899.99, category_name: 'Smartphones', stock: 26, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Lenovo ThinkPad X1 Carbon', description: 'Ultra-portable business laptop with durable design and powerful performance.', price: 1699.99, category_name: 'Laptops', stock: 33, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Ecobee SmartThermostat', description: 'Wi-Fi enabled thermostat with voice control and energy-saving features.', price: 249.99, category_name: 'Smart Home Devices', stock: 42, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Sony PlayStation VR', description: 'Virtual reality headset for immersive gaming experiences on PlayStation.', price: 299.99, category_name: 'Gaming Consoles', stock: 12, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Xiaomi Mi 12 Ultra', description: 'High-end Android phone with 200MP camera and Snapdragon 8 Gen 2 processor.', price: 1199.99, category_name: 'Smartphones', stock: 29, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'ASUS ROG Zephyrus G14', description: 'Gaming laptop with powerful AMD Ryzen processor and NVIDIA RTX graphics.', price: 1599.99, category_name: 'Laptops', stock: 31, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Ring Video Doorbell Pro', description: 'Advanced video doorbell with motion detection and two-way audio.', price: 249.99, category_name: 'Smart Home Devices', stock: 39, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Nintendo Switch Lite', description: 'Compact version of Nintendo Switch designed for handheld gaming.', price: 199.99, category_name: 'Gaming Consoles', stock: 16, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Motorola Edge 20 Pro', description: 'Flagship smartphone with 108MP camera and Snapdragon 870 processor.', price: 699.99, category_name: 'Smartphones', stock: 24, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Microsoft Surface Laptop 5', description: 'Sleek and powerful laptop with touchscreen and Windows 11.', price: 1299.99, category_name: 'Laptops', stock: 34, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Philips Hue Smart Bulb Starter Kit', description: 'Set of smart bulbs with color-changing capabilities and app control.', price: 149.99, category_name: 'Smart Home Devices', stock: 37, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Sony PlayStation 4 Pro', description: 'Enhanced version of PlayStation 4 with 4K gaming and HDR support.', price: 399.99, category_name: 'Gaming Consoles', stock: 19, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Oppo Find X5 Pro', description: 'Flagship smartphone with 120Hz AMOLED display and Snapdragon 8 Gen 1.', price: 1099.99, category_name: 'Smartphones', stock: 27, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Razer Blade 14', description: 'Compact gaming laptop with powerful RTX graphics and QHD display.', price: 1999.99, category_name: 'Laptops', stock: 29, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Arlo Pro 4 Security Camera', description: 'Wireless security camera with 2K video resolution and color night vision.', price: 199.99, category_name: 'Smart Home Devices', stock: 36, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Sony PlayStation 3', description: 'Previous generation gaming console with a vast library of games.', price: 299.99, category_name: 'Gaming Consoles', stock: 14, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Realme GT 2 Pro', description: 'High-performance smartphone with Snapdragon 8 Gen 1 and 65W fast charging.', price: 799.99, category_name: 'Smartphones', stock: 26, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Acer Predator Helios 300', description: 'Gaming laptop with powerful Intel i7 CPU and RTX 3060 GPU.', price: 1499.99, category_name: 'Laptops', stock: 32, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'TP-Link Kasa Smart Plug', description: 'Smart plug for controlling home appliances via smartphone.', price: 29.99, category_name: 'Smart Home Devices', stock: 35, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Sony PlayStation VR2', description: 'Next-generation virtual reality headset for PlayStation 5.', price: 499.99, category_name: 'Gaming Consoles', stock: 13, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Vivo X80 Pro', description: 'Flagship smartphone with ZEISS optics and powerful MediaTek Dimensity 9000 chipset.', price: 899.99, category_name: 'Smartphones', stock: 24, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'MSI GS66 Stealth', description: 'High-end gaming laptop with RTX 3080 GPU and 300Hz display.', price: 2499.99, category_name: 'Laptops', stock: 31, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'August Smart Lock Pro', description: 'Smart lock with remote access and auto-unlock features.', price: 229.99, category_name: 'Smart Home Devices', stock: 34, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Nintendo Wii', description: 'Classic gaming console with motion-controlled games.', price: 249.99, category_name: 'Gaming Consoles', stock: 17, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Asus Zenfone 8', description: 'Compact flagship smartphone with powerful performance and 120Hz display.', price: 699.99, category_name: 'Smartphones', stock: 22, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'HP Omen 15', description: 'Gaming laptop with powerful specs and customizable RGB lighting.', price: 1399.99, category_name: 'Laptops', stock: 30, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Ecobee4 Smart Thermostat', description: 'Smart thermostat with built-in Amazon Alexa.', price: 199.99, category_name: 'Smart Home Devices', stock: 38, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Sony PlayStation Vita', description: 'Handheld gaming console with a large library of games.', price: 199.99, category_name: 'Gaming Consoles', stock: 12, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Oppo Find N', description: 'Foldable smartphone with a versatile form factor and high-end specs.', price: 1499.99, category_name: 'Smartphones', stock: 25, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Dell Alienware m15 R6', description: 'Gaming laptop with advanced cooling and powerful hardware.', price: 1999.99, category_name: 'Laptops', stock: 27, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Wyze Cam v3', description: 'Affordable security camera with color night vision and motion detection.', price: 39.99, category_name: 'Smart Home Devices', stock: 33, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Sony PlayStation 2', description: 'Classic gaming console with an extensive library of games.', price: 149.99, category_name: 'Gaming Consoles', stock: 18, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Nokia 8.3 5G', description: '5G smartphone with PureView quad camera and ZEISS optics.', price: 699.99, category_name: 'Smartphones', stock: 21, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Razer Blade Stealth 13', description: 'Ultrabook with powerful specs and 13.3-inch display.', price: 1599.99, category_name: 'Laptops', stock: 26, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Nest Cam Outdoor', description: 'Outdoor security camera with weatherproof design and 24/7 live video.', price: 199.99, category_name: 'Smart Home Devices', stock: 32, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Nintendo GameCube', description: 'Retro gaming console with classic titles and unique design.', price: 99.99, category_name: 'Gaming Consoles', stock: 15, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Realme GT Neo 2', description: 'Mid-range smartphone with Snapdragon 870 and AMOLED display.', price: 499.99, category_name: 'Smartphones', stock: 24, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'HP Envy 14', description: 'Sleek and powerful laptop with vibrant display and long battery life.', price: 1299.99, category_name: 'Laptops', stock: 29, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'August Wi-Fi Smart Lock', description: 'Smart lock with remote access and easy installation.', price: 249.99, category_name: 'Smart Home Devices', stock: 30, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Sony PlayStation Classic', description: 'Miniature version of the original PlayStation with pre-loaded games.', price: 99.99, category_name: 'Gaming Consoles', stock: 20, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Asus ROG Phone 5', description: 'Gaming smartphone with high refresh rate display and powerful performance.', price: 999.99, category_name: 'Smartphones', stock: 23, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Apple MacBook Air M1', description: 'Ultra-thin laptop with Apple\'s M1 chip for impressive performance.', price: 999.99, category_name: 'Laptops', stock: 28, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Ring Video Doorbell 4', description: 'Smart video doorbell with improved motion detection and 1080p video.', price: 199.99, category_name: 'Smart Home Devices', stock: 37, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Sony PlayStation 1', description: 'Iconic gaming console that started it all for PlayStation.', price: 129.99, category_name: 'Gaming Consoles', stock: 16, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Samsung Galaxy S21 Ultra', description: 'Flagship smartphone with advanced camera features and 108MP sensor.', price: 1199.99, category_name: 'Smartphones', stock: 20, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Asus ZenBook Duo 14', description: 'Laptop with dual-screen setup for increased productivity.', price: 1499.99, category_name: 'Laptops', stock: 24, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Google Nest Hub Max', description: 'Smart display with Google Assistant and built-in camera.', price: 229.99, category_name: 'Smart Home Devices', stock: 28, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Microsoft Xbox Series S', description: 'Compact gaming console with next-gen performance.', price: 299.99, category_name: 'Gaming Consoles', stock: 18, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'OnePlus 9 Pro', description: 'Flagship smartphone with Hasselblad camera and fast wireless charging.', price: 969.99, category_name: 'Smartphones', stock: 22, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Gigabyte Aero 15', description: 'High-performance laptop with 4K OLED display and RTX 3070 GPU.', price: 1899.99, category_name: 'Laptops', stock: 25, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Philips Hue Starter Kit', description: 'Smart lighting system with color-changing bulbs and hub.', price: 179.99, category_name: 'Smart Home Devices', stock: 34, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) },
  { name: 'Nintendo 3DS', description: 'Portable gaming console with 3D display and extensive game library.', price: 199.99, category_name: 'Gaming Consoles', stock: 19, image_url: Faker::LoremFlickr.image(size: "300x300", search_terms: ['electronics']) }
]

products_data.each do |products_data|
  category = Category.find_by(name: products_data[:category_name])
  if category
    puts "Creating product: #{products_data[:name]} in category: #{category.name}" # Debug statement
    Product.create!(
      name: products_data[:name],
      description: products_data[:description],
      price: products_data[:price],
      category: category,
      stock: products_data[:stock],
      image_url: products_data[:image_url]
    )
  else
    puts "Category not found for products_data: #{products_data[:name]}"
  end
end

# Verify product creation
Product.all.each do |product|
    puts "Product created: #{product.name} in category #{product.category.name} with stock #{product.stock}"
  end

puts "Products created successfully."
