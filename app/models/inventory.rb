# == Schema Information
#
# Table name: inventories
#
#  id         :bigint(8)        not null, primary key
#  loc_id     :integer
#  bin_id     :integer
#  quantity   :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  aisle_id   :integer
#  product_id :integer
#

class Inventory < ApplicationRecord

  # def product
  #   Product.find(self.product_id)
  # end

	belongs_to :product
	has_many :inventory_details
	has_many :orders, through: :inventory_details

	validates :product_id, presence: true

	scope :inventory_with_products, -> { includes(:product) }

	scope :filter_status_all, -> (product_name) { joins(:product)
										.where("products.name LIKE ?", "%#{product_name}%") }

	scope :filter_status_low, -> (product_name) { joins(:product)
										.where("products.name LIKE ? AND inventories.quantity < 3", "%#{product_name}%") }

	scope :filter_status_sufficient, -> (product_name) { joins(:product)
										.where("products.name LIKE ? AND inventories.quantity >= 3", "%#{product_name}%") }

	def _quantity
    	quantity || 0
	end
	  
	def _cartons
    	cartons || 0
	end
	  
	# def _total_quantity
    # 	total_quantity || 0
  	# end

	def total_quantity
		total_quantity_by_orders = OrderEntry.where(:product_id => self.product_id).sum(:quantity)
		if self._quantity > total_quantity_by_orders
			self._quantity - total_quantity_by_orders
		else
			0
		end
	end

	require 'csv'

	def self.import(file)
	  spreadsheet= open_spreadsheet(file)
	  spreadsheet.default_sheet = spreadsheet.sheets[0]
  
	  headers = Hash.new
	  spreadsheet.row(1).each_with_index {|header,i|headers[header] = i}
	  ((spreadsheet.first_row + 1)..spreadsheet.last_row).each do |row|
  
		hotel = spreadsheet.row(row)[headers['Hotel']]
		item = spreadsheet.row(row)[headers['Item']]
		per_carton = spreadsheet.row(row)[headers['Per Carton']]
		carton = spreadsheet.row(row)[headers['Cartons']]
		total_quantity = spreadsheet.row(row)[headers['Total Quantity']]
		hotel_price = spreadsheet.row(row)[headers['hotel price']]
		price_per_carton = spreadsheet.row(row)[headers['Price Per Carton']]
		full_value = spreadsheet.row(row)[headers['Full Value']]
		vendor_price = spreadsheet.row(row)[headers['vendor price']]
		total_cost = spreadsheet.row(row)[headers['Total Cost']]
  
		product = Product.find_by_name(item)
		hotelid = Hotel.find_by_name(hotel)

		if !product.present? && !item.nil?

			p = Product.new
			if hotelid.present?

				p.name = item
				p.total_cost = total_cost 
				p.vendor_price = vendor_price
				p.full_value = full_value
				p.price_per_carton = price_per_carton
				p.hotel_price = hotel_price
				p.per_carton = per_carton
				p.hotel_id = hotelid.id

			else

				p.name = item
				p.total_cost = total_cost 
				p.vendor_price = vendor_price
				p.full_value = full_value
				p.price_per_carton = price_per_carton
				p.hotel_price = hotel_price
				p.per_carton = per_carton
				
			end
			p.save

			inventory = Inventory.where(product_id: Product.last.id)
			if inventory.present?
				inventory.update(cartons: carton, quantity: total_quantity)
			else
				Inventory.create(product_id: Product.last.id, cartons: carton, quantity: total_quantity)
			end
		elsif product.present?
			if hotelid.present?

				product.name = item
				product.total_cost = total_cost 
				product.vendor_price = vendor_price
				product.full_value = full_value
				product.price_per_carton = price_per_carton
				product.hotel_price = hotel_price
				product.per_carton = per_carton
				product.hotel_id = hotelid.id

			else
				product.name = item
				product.total_cost = total_cost 
				product.vendor_price = vendor_price
				product.full_value = full_value
				product.price_per_carton = price_per_carton
				product.hotel_price = hotel_price
				product.per_carton = per_carton

			end
			product.save

			inventory = Inventory.where(product_id: product.id)
			if inventory.present?
				inventory.update(cartons: carton, quantity: total_quantity)
			else
				Inventory.create(product_id: product.id, cartons: carton, quantity: total_quantity)
			end
		end
  
	  end
  
	end

	def self.open_spreadsheet(file)
		case File.extname(file.original_filename)
		when ".csv" then Roo::CSV.new(file.path)
		when ".xls" then Roo::Excel.new (file.path)
		when ".xlsx" then Roo::Excelx.new(file.path)
		else raise "Unknown file type: #{file.original_filename}"
		end
	end

end
