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

  before_destroy :check_for_associations

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
      
      name = spreadsheet.row(row)[headers['Vendor']]
      company = spreadsheet.row(row)[headers['Company']]
      phone = spreadsheet.row(row)[headers['Main Phone']]
      fax = spreadsheet.row(row)[headers['Fax']]
      balance = spreadsheet.row(row)[headers['Balance']]
      balance_total = spreadsheet.row(row)[headers['Balance Total']]
      bill_1 = spreadsheet.row(row)[headers['Bill from 1']]
      bill_2 = spreadsheet.row(row)[headers['Bill from 2']]
      bill_3 = spreadsheet.row(row)[headers['Bill from 3']]
      bill_4 = spreadsheet.row(row)[headers['Bill from 4']]
      bill_5 = spreadsheet.row(row)[headers['Bill from 5']]

      vend = Vendor.new

      vend.name = name
      vend.company = company
      vend.phone = phone
      vend.fax = fax
      vend.balance = balance
      vend.balance_total = balance_total
      vend.bill_from_1 = bill_1
      vend.bill_from_2 = bill_2
      vend.bill_from_3 = bill_3
      vend.bill_from_4 = bill_4
      vend.bill_from_5 = bill_5

      vend.save
    end

    # spreadsheet= open_spreadsheet(file)
    # header=spreadsheet.row(1)
    # (2..spreadsheet.last_row).each do |i|
    #   row=Hash[[header,spreadsheet.row(i)].transpose]
    #   puts "#{row.to_json}"
    #   temp_vendor = Vendor.find_by_name(row["name"])
    #   if !temp_vendor.present?
    #     @address = Address.where(:street => row['Bill from 1'], :street_2 => row['Bill from 2']).first

    #     if !@address.present?
    #       @address = Address.new
    #       @address.street = row['Bill from 1']
    #       @address.street_2 = row['Bill from 2']
    #       @arr1 = []
    #       @arr2 = []
    #       if row['Bill from 3'].present? && row['Bill from 3'] != ''
    #         @arr1 = row['Bill from 3'].split(', ')
    #         if @arr1.length > 0
    #           @address.city = @arr1[0]
    #         end
    #         if @arr1[1].present?
    #           @arr2 = @arr1[1].split(' ')
    #           if @arr2.length > 0
    #             @address.state = @arr2[0]
    #             if @arr2[1].present? && !@arr2[1].nil?
    #               @address.zip = @arr2[0]
    #             end
    #           end
    #         end
    #       end
    #       if row['Main Phone'].present? && row['Main Phone'] != ''
    #         @address.phone = row['Main Phone']
    #       end
    #       @address.save
    #     end

    #     vendor = Vendor.new
    #     vendor.name = row["Vendor"]
    #     if @address.present?
    #       vendor.billing_address = @address.id
    #     end
    #     vendor.save
    #   end
    # end
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
