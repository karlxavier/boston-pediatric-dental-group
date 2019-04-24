# == Schema Information
#
# Table name: vendors
#
#  id              :bigint(8)        not null, primary key
#  name            :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  lead_time       :integer
#  country_origin  :string
#  product_id      :bigint(8)
#  email           :string
#  billing_address :integer
#

class Vendor < ApplicationRecord
  
  audited
  
  require 'csv'
  
  has_many :vendors_products
  # has_many :products, through: :vendors_products
  has_many :products
  has_many :order_entries, through: :products

  has_many :vendor_categories
  has_many :categories, through: :vendor_categories

  has_many :vendor_reviews
  has_many :orders

  validates :name, presence: true
  validates :name, uniqueness: true

  # before_destroy :check_for_associations

  def country_name
    if !country_origin.nil?
      country = ISO3166::Country[country_origin]
      country.translations[I18n.locale.to_s] || country.name
    else
      'N/A'
    end
  end

  def mailboxer_email(object)
    #Check if an email should be sent for that object
    #if true
    return "#{self.email}"
    #if false
    #return nil
  end
  def notification_email(object)
    #Check if an email should be sent for that object
    #if true
    return "#{self.email}"
    #if false
    #return nil
  end

  require 'csv'

  def self.import(file)


    spreadsheet= open_spreadsheet(file)
    spreadsheet.default_sheet = spreadsheet.sheets[0]

    headers = Hash.new
    spreadsheet.row(1).each_with_index {|header,i|headers[header] = i}
    ((spreadsheet.first_row + 1)..spreadsheet.last_row).each do |row|
      
      name = spreadsheet.row(row)[headers['Vendors']]

      vendor = Vendor.where(name: name).first
      if vendor.present?
      else
        v = Vendor.new
        v.name = name
        v.save
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

  private

    def check_for_associations
      if vendors_products.any? || products.any? || vendor_categories.any? || vendor_reviews.any?
        throw(:abort)
      end
    end

end
