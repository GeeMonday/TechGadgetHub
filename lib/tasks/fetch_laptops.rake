# lib/tasks/fetch_laptops.rake

require 'uri'
require 'net/http'
require 'json'
require_relative '../../config/environment' # Adjust the path if necessary

namespace :populate do
  desc "Fetch laptops from Best Buy API and populate the database"
  task fetch_laptops: :environment do
    # Function to make API request and parse response
    def fetch_laptops_category
      url = URI("https://bestbuy14.p.rapidapi.com/getCategoryByURL?url=https%3A%2F%2Fwww.bestbuy.com%2Fsite%2Flaptop-computers%2Fall-laptops%2Fpcmcat138500050001.c%3Fid%3Dpcmcat138500050001")
      http = Net::HTTP.new(url.host, url.port)
      http.use_ssl = true

      request = Net::HTTP::Get.new(url)
      request["x-rapidapi-key"] = 'b4f4373bfemshe112a626d9e075bp17ba2ejsn3404677af025'
      request["x-rapidapi-host"] = 'bestbuy14.p.rapidapi.com'

      response = http.request(request)
      data = JSON.parse(response.read_body)
      puts "API Response Data: #{data.inspect}" # Debug line to inspect response data
      data
    rescue JSON::ParserError => e
      puts "Failed to parse JSON response: #{e.message}"
      nil
    rescue StandardError => e
      puts "HTTP Request failed: #{e.message}"
      nil
    end

    # Function to process and save the fetched data
    def process_and_save_laptops_data(data)
      return if data.nil?

      # Print the structure of the data to understand it
      puts "Processing Data: #{data.inspect}"

      # Check if the response data contains 'categories' and 'products' fields
      if data.is_a?(Hash)
        categories = data['categories'] || []
        products = data['products'] || []

        if categories.empty? || products.empty?
          puts "Categories or Products data is missing in the response."
          puts "Response data: #{data.inspect}"
          return
        end

        # Process categories
        categories.each do |category_data|
          if category_data.is_a?(Hash)
            Category.find_or_create_by(id: category_data['id']) do |category|
              category.name = category_data['name']
            end
          else
            puts "Unexpected format for category data: #{category_data.inspect}"
          end
        end

        # Process products and product_categories
        products.each do |product_data|
          if product_data.is_a?(Hash)
            product = Product.find_or_create_by(id: product_data['id']) do |prod|
              prod.name = product_data['name']
              prod.description = product_data['description']
              prod.price = product_data['price']
              prod.stock = product_data['stock']
              prod.image_url = product_data['image_url']
            end

            # Create or update product_category associations
            category_ids = product_data['category_ids'] || [] # Adjust based on your API response
            category_ids.each do |category_id|
              category = Category.find_by(id: category_id)
              if category
                ProductCategory.find_or_create_by(product: product, category: category)
              else
                puts "Category not found for Product: #{product_data['name']}"
              end
            end
          else
            puts "Unexpected format for product data: #{product_data.inspect}"
          end
        end
      else
        puts "Unexpected response format: #{data.inspect}"
      end
    end

    # Fetch and process laptops category data
    data = fetch_laptops_category
    process_and_save_laptops_data(data)
  end
end
