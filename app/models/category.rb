# == Schema Information
#
# Table name: categories
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent     :integer
#

class Category < ApplicationRecord
	has_many :vendor_categories
	has_many :vendors, through: :vendor_categories

	validates :name, presence: true

	require 'csv'

  	def self.import(file)
  		spreadsheet= open_spreadsheet(file)
	    spreadsheet.default_sheet = spreadsheet.sheets[0]

	    headers = Hash.new
	    spreadsheet.row(1).each_with_index {|header,i|headers[header] = i}
	    ((spreadsheet.first_row + 1)..spreadsheet.last_row).each do |row|
	      
	    	name = spreadsheet.row(row)[headers['Category']]

	    	category = Category.new
	    	category.name = name

	    	category.save

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
