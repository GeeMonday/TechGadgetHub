# This file should ensure the existence of records required to run the application in every environment (production, development, test).
# The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Delete existing records
ProductCategory.delete_all
Product.delete_all
Category.delete_all

puts "Deleted all categories, products, and product categories."

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
  { name: 'iPhone 13 Pro', description: 'The latest iPhone with advanced camera and performance.', price: 999.99, category_name: 'Smartphones', stock: 50, image_url: 'https://example.com/images/iphone_13_pro.jpg' },
  { name: 'MacBook Pro 2023', description: 'Powerful laptop for professionals with new M2 chip.', price: 1999.99, category_name: 'Laptops', stock: 30, image_url: 'https://example.com/images/macbook_pro_2023.jpg' },
  { name: 'Nest Thermostat', description: 'Smart thermostat with energy-saving features.', price: 199.99, category_name: 'Smart Home Devices', stock: 40, image_url: 'https://example.com/images/nest_thermostat.jpg' },
  { name: 'PlayStation 5', description: 'Next-gen gaming console with ultra-fast SSD.', price: 499.99, category_name: 'Gaming Consoles', stock: 20, image_url: 'https://example.com/images/playstation_5.jpg' },
  { name: 'Samsung Galaxy S22 Ultra', description: 'Flagship smartphone with a powerful camera system and 5G support.', price: 1199.99, category_name: 'Smartphones', stock: 25, image_url: 'https://example.com/images/galaxy_s22_ultra.jpg' },
  { name: 'Dell XPS 15', description: 'High-performance laptop with stunning 4K display and powerful CPU.', price: 1799.99, category_name: 'Laptops', stock: 35, image_url: 'https://example.com/images/dell_xps_15.jpg' },
  { name: 'Google Nest Hub Max', description: 'Smart display with built-in Google Assistant for smart home control.', price: 229.99, category_name: 'Smart Home Devices', stock: 45, image_url: 'https://example.com/images/nest_hub_max.jpg' },
  { name: 'Xbox Series X', description: 'Microsoft\'s latest gaming console with 4K gaming support and SSD storage.', price: 599.99, category_name: 'Gaming Consoles', stock: 15, image_url: 'https://example.com/images/xbox_series_x.jpg' },
  { name: 'OnePlus 10 Pro', description: 'Premium Android smartphone with Hasselblad camera technology.', price: 899.99, category_name: 'Smartphones', stock: 28, image_url: 'https://example.com/images/oneplus_10_pro.jpg' },
  { name: 'HP Spectre x360', description: 'Convertible laptop with OLED display and powerful Intel processor.', price: 1499.99, category_name: 'Laptops', stock: 32, image_url: 'https://example.com/images/hp_spectre_x360.jpg' },
  { name: 'Amazon Echo Show 15', description: 'Large screen smart display for home entertainment and video calling.', price: 249.99, category_name: 'Smart Home Devices', stock: 38, image_url: 'https://example.com/images/echo_show_15.jpg' },
  { name: 'Nintendo Switch OLED', description: 'Updated version of Nintendo\'s popular console with OLED screen.', price: 349.99, category_name: 'Gaming Consoles', stock: 18, image_url: 'https://example.com/images/switch_oled.jpg' },
  { name: 'Google Pixel 6', description: 'Google\'s flagship phone with enhanced camera features and 5G support.', price: 899.99, category_name: 'Smartphones', stock: 26, image_url: 'https://example.com/images/pixel_6.jpg' },
  { name: 'Lenovo ThinkPad X1 Carbon', description: 'Ultra-portable business laptop with durable design and powerful performance.', price: 1699.99, category_name: 'Laptops', stock: 33, image_url: 'https://example.com/images/thinkpad_x1_carbon.jpg' },
  { name: 'Ecobee SmartThermostat', description: 'Wi-Fi enabled thermostat with voice control and energy-saving features.', price: 249.99, category_name: 'Smart Home Devices', stock: 42, image_url: 'https://example.com/images/ecobee_smart_thermostat.jpg' },
  { name: 'Sony PlayStation VR', description: 'Virtual reality headset for immersive gaming experiences on PlayStation.', price: 299.99, category_name: 'Gaming Consoles', stock: 12, image_url: 'https://example.com/images/playstation_vr.jpg' },
  { name: 'Xiaomi Mi 12 Ultra', description: 'High-end Android phone with 200MP camera and Snapdragon 8 Gen 2 processor.', price: 1199.99, category_name: 'Smartphones', stock: 29, image_url: 'https://example.com/images/xiaomi_mi_12_ultra.jpg' },
  { name: 'ASUS ROG Zephyrus G14', description: 'Gaming laptop with powerful AMD Ryzen processor and NVIDIA RTX graphics.', price: 1599.99, category_name: 'Laptops', stock: 31, image_url: 'https://example.com/images/rog_zephyrus_g14.jpg' },
  { name: 'Ring Video Doorbell Pro', description: 'Advanced video doorbell with motion detection and two-way audio.', price: 249.99, category_name: 'Smart Home Devices', stock: 39, image_url: 'https://example.com/images/ring_doorbell_pro.jpg' },
  { name: 'Nintendo Switch Lite', description: 'Compact version of Nintendo Switch designed for handheld gaming.', price: 199.99, category_name: 'Gaming Consoles', stock: 16, image_url: 'https://example.com/images/switch_lite.jpg' },
  { name: 'Motorola Edge 20 Pro', description: 'Flagship smartphone with 108MP camera and Snapdragon 870 processor.', price: 699.99, category_name: 'Smartphones', stock: 24, image_url: 'https://example.com/images/edge_20_pro.jpg' },
  { name: 'Microsoft Surface Laptop 5', description: 'Sleek and powerful laptop with touchscreen and Windows 11.', price: 1299.99, category_name: 'Laptops', stock: 34, image_url: 'https://example.com/images/surface_laptop_5.jpg' },
  { name: 'Philips Hue Smart Bulb Starter Kit', description: 'Set of smart bulbs with color-changing capabilities and app control.', price: 149.99, category_name: 'Smart Home Devices', stock: 37, image_url: 'https://example.com/images/hue_starter_kit.jpg' },
  { name: 'Sony PlayStation 4 Pro', description: 'Enhanced version of PlayStation 4 with 4K gaming and HDR support.', price: 399.99, category_name: 'Gaming Consoles', stock: 19, image_url: 'https://example.com/images/ps4_pro.jpg' },
  { name: 'Oppo Find X5 Pro', description: 'Flagship smartphone with 120Hz AMOLED display and Snapdragon 8 Gen 1.', price: 1099.99, category_name: 'Smartphones', stock: 27, image_url: 'https://example.com/images/oppo_find_x5_pro.jpg' },
  { name: 'Razer Blade 15', description: 'High-end gaming laptop with advanced cooling system and powerful GPU.', price: 2199.99, category_name: 'Laptops', stock: 36, image_url: 'https://example.com/images/razer_blade_15.jpg' },
  { name: 'August Smart Lock Pro', description: 'Smart lock with remote access and integration with smart home systems.', price: 229.99, category_name: 'Smart Home Devices', stock: 41, image_url: 'https://example.com/images/august_smart_lock_pro.jpg' },
  { name: 'Nintendo Switch Pro Controller', description: 'Ergonomic controller for Nintendo Switch with improved grip and battery life.', price: 69.99, category_name: 'Gaming Consoles', stock: 17, image_url: 'https://example.com/images/switch_pro_controller.jpg' },
  { name: 'Google Pixel 6 Pro', description: 'Google\'s premium smartphone with advanced camera and 5G connectivity.', price: 1099.99, category_name: 'Smartphones', stock: 23, image_url: 'https://example.com/images/pixel_6_pro.jpg' },
  { name: 'Acer Predator Helios 300', description: 'Gaming laptop with powerful specs and advanced cooling system.', price: 1499.99, category_name: 'Laptops', stock: 35, image_url: 'https://example.com/images/predator_helios_300.jpg' },
  { name: 'Sonos One SL', description: 'Smart speaker with rich sound quality and voice control integration.', price: 179.99, category_name: 'Smart Home Devices', stock: 43, image_url: 'https://example.com/images/sonos_one_sl.jpg' },
  { name: 'Sony DualSense Wireless Controller', description: 'Advanced controller for PlayStation 5 with haptic feedback and adaptive triggers.', price: 69.99, category_name: 'Gaming Consoles', stock: 21, image_url: 'https://example.com/images/dualsense_controller.jpg' },
  { name: 'Vivo X80 Pro', description: 'Flagship smartphone with Zeiss optics and powerful camera features.', price: 999.99, category_name: 'Smartphones', stock: 22, image_url: 'https://example.com/images/vivo_x80_pro.jpg' },
  { name: 'HP Envy x360', description: 'Convertible laptop with AMD Ryzen processor and long battery life.', price: 999.99, category_name: 'Laptops', stock: 31, image_url: 'https://example.com/images/envy_x360.jpg' },
  { name: 'LIFX Color A19', description: 'Smart LED bulb with 16 million colors and app control.', price: 59.99, category_name: 'Smart Home Devices', stock: 37, image_url: 'https://example.com/images/lifx_color_a19.jpg' },
  { name: 'Nintendo Switch Joy-Con', description: 'Pair of Joy-Con controllers for Nintendo Switch with motion control.', price: 79.99, category_name: 'Gaming Consoles', stock: 17, image_url: 'https://example.com/images/joy_con.jpg' }
]

# Create products and associate them with categories
products_data.each do |product_data|
  category = Category.find_by(name: product_data[:category_name])
  product = Product.find_or_create_by(
    name: product_data[:name],
    description: product_data[:description],
    price: product_data[:price],
    stock: product_data[:stock],
    image_url: product_data[:image_url]
  )
  
  # Create ProductCategory association
  if category
    ProductCategory.find_or_create_by(
      product: product,
      category: category
    )
  else
    puts "Category not found: #{product_data[:category_name]}"
  end
end

puts "Products created: #{Product.count}"
puts "Product categories created: #{ProductCategory.count}"
