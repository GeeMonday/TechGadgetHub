# This file should ensure the existence of records required to run the application in every environment (production, development, test).
# The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).

# Delete existing records
ProductCategory.delete_all
Product.delete_all
Category.delete_all

puts "Deleted all categories, products, and product categories."

# Seed categories using Faker
categories = ['Smartphones', 'Laptops', 'Smart Home Devices', 'Gaming Consoles']

categories.each do |category_name|
  Category.find_or_create_by(name: category_name)
end

# Verify categories creation
Category.all.each do |category|
  puts "Category created: #{category.name} with ID: #{category.id}"
end

# Seed products with Faker data
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
  { name: 'Nintendo Switch Joy-Con', description: 'Pair of Joy-Con controllers for Nintendo Switch with motion control.', price: 79.99, category_name: 'Gaming Consoles', stock: 17, image_url: 'https://example.com/images/joy_con.jpg'},
  { name: 'Apple Watch Series 8', description: 'Latest smartwatch with advanced health monitoring features.', price: 399.99, category_name: 'Smartphones', stock: 40, image_url: 'https://example.com/images/apple_watch_series_8.jpg' },
  { name: 'Samsung Galaxy Watch 5', description: 'Feature-rich smartwatch with health tracking and AMOLED display.', price: 299.99, category_name: 'Smartphones', stock: 35, image_url: 'https://example.com/images/galaxy_watch_5.jpg' },
  { name: 'Dell Inspiron 14', description: 'Versatile laptop with a balance of performance and affordability.', price: 749.99, category_name: 'Laptops', stock: 45, image_url: 'https://example.com/images/dell_inspiron_14.jpg' },
  { name: 'Acer Aspire 5', description: 'Budget-friendly laptop with a solid performance for everyday tasks.', price: 699.99, category_name: 'Laptops', stock: 50, image_url: 'https://example.com/images/acer_aspire_5.jpg' },
  { name: 'JBL Flip 6', description: 'Portable Bluetooth speaker with powerful sound and waterproof design.', price: 129.99, category_name: 'Smart Home Devices', stock: 55, image_url: 'https://example.com/images/jbl_flip_6.jpg' },
  { name: 'Sonos Arc', description: 'High-end soundbar with Dolby Atmos support for immersive audio.', price: 799.99, category_name: 'Smart Home Devices', stock: 25, image_url: 'https://example.com/images/sonos_arc.jpg' },
  { name: 'Google Pixel Buds Pro', description: 'Wireless earbuds with active noise cancellation and Google Assistant integration.', price: 199.99, category_name: 'Smart Home Devices', stock: 30, image_url: 'https://example.com/images/pixel_buds_pro.jpg' },
  { name: 'Anker PowerCore 10000', description: 'Compact power bank with 10,000mAh capacity for on-the-go charging.', price: 29.99, category_name: 'Smart Home Devices', stock: 60, image_url: 'https://example.com/images/anker_powercore_10000.jpg' },
  { name: 'Kindle Paperwhite', description: 'E-reader with high-resolution display and built-in light for reading anywhere.', price: 139.99, category_name: 'Smart Home Devices', stock: 40, image_url: 'https://example.com/images/kindle_paperwhite.jpg' },
  { name: 'Apple AirPods Pro', description: 'Wireless earbuds with noise cancellation and transparency mode.', price: 249.99, category_name: 'Smartphones', stock: 45, image_url: 'https://example.com/images/airpods_pro.jpg' },
  { name: 'Oculus Quest 2', description: 'Standalone VR headset with a wide range of games and applications.', price: 299.99, category_name: 'Smart Home Devices', stock: 25, image_url: 'https://example.com/images/oculus_quest_2.jpg' },
  { name: 'Corsair K95 RGB Platinum', description: 'Mechanical gaming keyboard with customizable RGB lighting and macro keys.', price: 199.99, category_name: 'Gaming Consoles', stock: 20, image_url: 'https://example.com/images/corsair_k95_rbg_platinum.jpg' },
  { name: 'Logitech MX Master 3', description: 'Advanced wireless mouse with customizable buttons and ergonomic design.', price: 129.99, category_name: 'Smart Home Devices', stock: 30, image_url: 'https://example.com/images/logitech_mx_master_3.jpg' },
  { name: 'Razer DeathAdder V2', description: 'Gaming mouse with high-precision sensor and customizable RGB lighting.', price: 79.99, category_name: 'Gaming Consoles', stock: 25, image_url: 'https://example.com/images/razer_deathadder_v2.jpg' },
  { name: 'SteelSeries Arctis 7', description: 'Wireless gaming headset with clear sound and comfortable design.', price: 149.99, category_name: 'Gaming Consoles', stock: 30, image_url: 'https://example.com/images/steelseries_arctis_7.jpg' },
  { name: 'BenQ ZOWIE XL2546', description: 'High-refresh-rate gaming monitor with dynamic contrast and motion blur reduction.', price: 329.99, category_name: 'Gaming Consoles', stock: 18, image_url: 'https://example.com/images/benq_zowie_xl2546.jpg' },
  { name: 'ASUS TUF Gaming VG27AQ', description: '27-inch monitor with 1440p resolution and high refresh rate for smooth gaming.', price: 399.99, category_name: 'Gaming Consoles', stock: 22, image_url: 'https://example.com/images/asus_tuf_gaming_vg27aq.jpg' },
  { name: 'Razer Naga X', description: 'Gaming mouse with 16 programmable buttons and lightweight design.', price: 79.99, category_name: 'Gaming Consoles', stock: 27, image_url: 'https://example.com/images/razer_naga_x.jpg' },
  { name: 'HP Omen 17', description: 'High-performance gaming laptop with powerful GPU and large display.', price: 2299.99, category_name: 'Laptops', stock: 15, image_url: 'https://example.com/images/hp_omen_17.jpg' },
  { name: 'MSI GE76 Raider', description: 'Gaming laptop with Intel Core i9 processor and NVIDIA GeForce RTX 3080.', price: 2499.99, category_name: 'Laptops', stock: 12, image_url: 'https://example.com/images/msi_ge76_raider.jpg' },
  { name: 'Alienware x17', description: 'Premium gaming laptop with high refresh rate and customizable RGB lighting.', price: 2999.99, category_name: 'Laptops', stock: 10, image_url: 'https://example.com/images/alienware_x17.jpg' },
  { name: 'Apple Mac Studio', description: 'Desktop computer with M1 Ultra chip for professional-grade performance.', price: 3999.99, category_name: 'Laptops', stock: 8, image_url: 'https://example.com/images/mac_studio.jpg' },
  { name: 'Wacom Cintiq 22', description: 'Professional drawing tablet with high-resolution screen and pen pressure sensitivity.', price: 649.99, category_name: 'Laptops', stock: 20, image_url: 'https://example.com/images/wacom_cintiq_22.jpg' },
  { name: 'Acer Predator X34', description: 'Curved ultrawide monitor with 100Hz refresh rate and NVIDIA G-SYNC support.', price: 1099.99, category_name: 'Gaming Consoles', stock: 18, image_url: 'https://example.com/images/acer_predator_x34.jpg' },
  { name: 'LG OLED55CXPUA', description: '55-inch OLED TV with 4K resolution and AI-powered picture adjustments.', price: 1499.99, category_name: 'Smart Home Devices', stock: 12, image_url: 'https://example.com/images/lg_oled55cxpua.jpg' },
  { name: 'Sony A8H OLED', description: '65-inch OLED TV with excellent color accuracy and sound quality.', price: 1899.99, category_name: 'Smart Home Devices', stock: 10, image_url: 'https://example.com/images/sony_a8h_oled.jpg' },
  { name: 'Apple TV 4K', description: 'Streaming device with support for 4K HDR and Dolby Atmos.', price: 179.99, category_name: 'Smart Home Devices', stock: 35, image_url: 'https://example.com/images/apple_tv_4k.jpg' },
  { name: 'Google Chromecast with Google TV', description: 'Streaming device with 4K support and Google TV integration.', price: 49.99, category_name: 'Smart Home Devices', stock: 45, image_url: 'https://example.com/images/google_chromecast.jpg' },
  { name: 'Logitech Harmony Elite', description: 'Universal remote control with smart home integration and touchscreen.', price: 349.99, category_name: 'Smart Home Devices', stock: 20, image_url: 'https://example.com/images/logitech_harmony_elite.jpg' },
  { name: 'Amazon Fire HD 10', description: '10.1-inch tablet with Full HD display and up to 64GB storage.', price: 149.99, category_name: 'Smart Home Devices', stock: 30, image_url: 'https://example.com/images/amazon_fire_hd_10.jpg' },
  { name: 'Huawei MatePad Pro', description: 'High-performance tablet with 120Hz display and M-Pencil support.', price: 499.99, category_name: 'Smart Home Devices', stock: 25, image_url: 'https://example.com/images/huawei_matepad_pro.jpg' },
  { name: 'GoPro HERO10 Black', description: 'Action camera with 5.3K video recording and advanced stabilization.', price: 499.99, category_name: 'Smart Home Devices', stock: 20, image_url: 'https://example.com/images/gopro_hero10_black.jpg' },
  { name: 'DJI Mini 2', description: 'Compact drone with 4K camera and long flight time.', price: 449.99, category_name: 'Smart Home Devices', stock: 18, image_url: 'https://example.com/images/dji_mini_2.jpg' },
  { name: 'Oculus Rift S', description: 'VR headset with high-resolution display and improved tracking.', price: 399.99, category_name: 'Smart Home Devices', stock: 15, image_url: 'https://example.com/images/oculus_rift_s.jpg' },
  { name: 'Samsung Galaxy Z Fold 4', description: 'Foldable smartphone with expansive screen and multitasking features.', price: 1799.99, category_name: 'Smartphones', stock: 25, image_url: 'https://example.com/images/galaxy_z_fold_4.jpg' },
  { name: 'Apple iPad Pro 11"', description: 'Powerful tablet with M1 chip and ProMotion display.', price: 799.99, category_name: 'Smart Home Devices', stock: 20, image_url: 'https://example.com/images/ipad_pro_11.jpg' },
  { name: 'Microsoft Surface Pro 8', description: '2-in-1 laptop with high-resolution touchscreen and Surface Pen support.', price: 1099.99, category_name: 'Laptops', stock: 15, image_url: 'https://example.com/images/surface_pro_8.jpg' },
  { name: 'Acer Swift 3', description: 'Affordable laptop with good performance for everyday use.', price: 699.99, category_name: 'Laptops', stock: 25, image_url: 'https://example.com/images/acer_swift_3.jpg' },
  { name: 'Lenovo Yoga 9i', description: '2-in-1 convertible laptop with high-resolution display and premium build.', price: 1399.99, category_name: 'Laptops', stock: 12, image_url: 'https://example.com/images/lenovo_yoga_9i.jpg' },
  { name: 'MSI GS66 Stealth', description: 'High-performance gaming laptop with thin profile and strong specs.', price: 2199.99, category_name: 'Laptops', stock: 8, image_url: 'https://example.com/images/msi_gs66_stealth.jpg' },
  { name: 'Apple HomePod mini', description: 'Compact smart speaker with powerful sound and smart home integration.', price: 99.99, category_name: 'Smart Home Devices', stock: 40, image_url: 'https://example.com/images/homepod_mini.jpg' },
  { name: 'Google Nest Audio', description: 'Smart speaker with rich sound and Google Assistant integration.', price: 99.99, category_name: 'Smart Home Devices', stock: 45, image_url: 'https://example.com/images/nest_audio.jpg' },
  { name: 'Amazon Echo Dot (5th Gen)', description: 'Compact smart speaker with Alexa and improved audio quality.', price: 49.99, category_name: 'Smart Home Devices', stock: 55, image_url: 'https://example.com/images/echo_dot_5th_gen.jpg' },
  { name: 'Ecovacs Deebot T8', description: 'Robot vacuum with advanced mapping and cleaning features.', price: 649.99, category_name: 'Smart Home Devices', stock: 25, image_url: 'https://example.com/images/ecovacs_deebot_t8.jpg' },
  { name: 'iRobot Roomba i7+', description: 'Robot vacuum with self-emptying base and smart mapping.', price: 799.99, category_name: 'Smart Home Devices', stock: 18, image_url: 'https://example.com/images/irobot_roomba_i7.jpg' },
  { name: 'Bose QuietComfort 45', description: 'Noise-canceling headphones with superior sound quality and comfort.', price: 329.99, category_name: 'Smart Home Devices', stock: 22, image_url: 'https://example.com/images/bose_quietcomfort_45.jpg' },
  { name: 'Sony WH-1000XM5', description: 'Premium noise-canceling headphones with industry-leading sound quality.', price: 349.99, category_name: 'Smart Home Devices', stock: 20, image_url: 'https://example.com/images/sony_wh_1000xm5.jpg' },
  { name: 'Jabra Elite 85h', description: 'Wireless headphones with active noise cancellation and long battery life.', price: 249.99, category_name: 'Smart Home Devices', stock: 25, image_url: 'https://example.com/images/jabra_elite_85h.jpg' },
  { name: 'Anker Soundcore Liberty Air 2 Pro', description: 'Affordable wireless earbuds with active noise cancellation and customizable sound.', price: 129.99, category_name: 'Smart Home Devices', stock: 30, image_url: 'https://example.com/images/anker_soundcore_liberty_air_2_pro.jpg' },
  { name: 'Roku Ultra', description: 'Streaming media player with 4K and HDR support, and voice remote.', price: 99.99, category_name: 'Smart Home Devices', stock: 40, image_url: 'https://example.com/images/roku_ultra.jpg' },
  { name: 'Amazon Fire TV Stick 4K', description: 'Streaming device with 4K Ultra HD and Alexa voice control.', price: 59.99, category_name: 'Smart Home Devices', stock: 50, image_url: 'https://example.com/images/fire_tv_stick_4k.jpg' },
  { name: 'Apple iPad Mini (6th Gen)', description: 'Compact tablet with A15 Bionic chip and True Tone display.', price: 499.99, category_name: 'Smart Home Devices', stock: 20, image_url: 'https://example.com/images/ipad_mini_6th_gen.jpg' },
  { name: 'Samsung Galaxy Tab S8+', description: 'High-performance tablet with S Pen support and AMOLED display.', price: 849.99, category_name: 'Smart Home Devices', stock: 15, image_url: 'https://example.com/images/galaxy_tab_s8_plus.jpg' },
  { name: 'Lenovo Smart Clock 2', description: 'Smart clock with Google Assistant and customizable faces.', price: 89.99, category_name: 'Smart Home Devices', stock: 35, image_url: 'https://example.com/images/lenovo_smart_clock_2.jpg' },
  { name: 'Google Nest Protect', description: 'Smart smoke and CO detector with remote alerts and voice notifications.', price: 119.99, category_name: 'Smart Home Devices', stock: 25, image_url: 'https://example.com/images/nest_protect.jpg' },
  { name: 'Netgear Nighthawk X6S', description: 'Tri-band WiFi router with high speeds and advanced features.', price: 249.99, category_name: 'Smart Home Devices', stock: 30, image_url: 'https://example.com/images/netgear_nighthawk_x6s.jpg' },
  { name: 'TP-Link Deco X20', description: 'Mesh WiFi system with high-speed internet and seamless coverage.', price: 229.99, category_name: 'Smart Home Devices', stock: 40, image_url: 'https://example.com/images/tp_link_deco_x20.jpg' },
  { name: 'Elgato Stream Deck', description: 'Customizable control panel for streaming with programmable keys.', price: 149.99, category_name: 'Gaming Consoles', stock: 22, image_url: 'https://example.com/images/elgato_stream_deck.jpg' },
  { name: 'Elgato Cam Link 4K', description: 'Capture device for connecting cameras to your computer for high-quality streaming.', price: 129.99, category_name: 'Gaming Consoles', stock: 18, image_url: 'https://example.com/images/elgato_cam_link_4k.jpg' },
  { name: 'Blue Yeti X', description: 'Professional USB microphone with high-quality sound and customizable features.', price: 169.99, category_name: 'Smart Home Devices', stock: 25, image_url: 'https://example.com/images/blue_yeti_x.jpg' },
  { name: 'HyperX QuadCast', description: 'Condenser microphone with built-in anti-vibration shock mount and LED lighting.', price: 139.99, category_name: 'Gaming Consoles', stock: 20, image_url: 'https://example.com/images/hyperx_quadcast.jpg' },
  { name: 'Herman Miller Aeron Chair', description: 'High-end ergonomic office chair with adjustable features and lumbar support.', price: 1299.99, category_name: 'Smart Home Devices', stock: 15, image_url: 'https://example.com/images/herman_miller_aeron_chair.jpg' },
  { name: 'Secretlab Titan Evo', description: 'Gaming chair with adjustable settings and premium materials.', price: 449.99, category_name: 'Gaming Consoles', stock: 12, image_url: 'https://example.com/images/secretlab_titan_evo.jpg' },
  { name: 'Corsair K95 RGB Platinum', description: 'Mechanical gaming keyboard with customizable RGB backlighting and macro keys.', price: 199.99, category_name: 'Gaming Consoles', stock: 22, image_url: 'https://example.com/images/corsair_k95_rgb_platinum.jpg' },
  { name: 'Razer DeathAdder V2', description: 'Gaming mouse with precise optical sensor and customizable buttons.', price: 79.99, category_name: 'Gaming Consoles', stock: 25, image_url: 'https://example.com/images/razer_deathadder_v2.jpg' },
  { name: 'BenQ ZOWIE XL2546K', description: 'Gaming monitor with 240Hz refresh rate and 24.5-inch display.', price: 349.99, category_name: 'Gaming Consoles', stock: 18, image_url: 'https://example.com/images/benq_zowie_xl2546k.jpg' }
]

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

