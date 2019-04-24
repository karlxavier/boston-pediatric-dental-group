# == Schema Information
#
# Table name: products
#
#  id                   :bigint(8)        not null, primary key
#  name                 :string
#  approval_status      :string
#  online_date          :datetime
#  offline_date         :datetime
#  unit                 :string
#  description          :string
#  base_product         :string
#  category             :integer
#  price                :decimal(, )
#  picture_file_name    :string
#  picture_content_type :string
#  picture_file_size    :integer
#  picture_updated_at   :datetime
#  variant_type         :string
#  style                :string
#  variants             :string
#  force_in_stock       :boolean
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  vendor_id            :integer
#  style_attribute_id   :bigint(8)
#  item_category_id     :integer
#  image_data           :text
#

class Product < ApplicationRecord
  has_many :style_attributes
  has_many :item_messages
  has_many :inventories
  belongs_to :vendor
  belongs_to :product_type
  belongs_to :product_account
  belongs_to :product_cog
  belongs_to :product_asset_account
  belongs_to :hotel

  has_many :order_entries
  has_many :orders, through: :order_entries

  has_many :chatroom_orders, through: :order_entries

  has_many :vendors_products
  has_many :vendors, through: :vendors_products

  include ProductImageUploader[:image]
  audited

  scope :product_wd_inventories, -> { includes(:inventories).order(id: :desc) }

  validates :name, presence: true

  # before_destroy :check_for_associations

  has_attached_file :picture, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  def _per_carton
    per_carton || 0
  end

  def picture_url
    @url = "#{ActionController::Base.helpers.asset_path('default-product.png')}"
    if self.image_data?
      @url = self.image_url(:original)
    elsif self.picture.exists?
      @url = self.picture.url
    end
    @url
  end

  def category_name
    if self.category.present?
      Category.find(self.category).name
    else
      ""
    end
  end

  def _cost
    cost || 0
  end

  def _purchase_price
    purchase_price || 0
  end

  def _price
    price || 0
  end

  require 'csv'

  def self.import(file)
    spreadsheet= open_spreadsheet(file)
    spreadsheet.default_sheet = spreadsheet.sheets[0]

    headers = Hash.new
    spreadsheet.row(1).each_with_index {|header,i|headers[header] = i}
    ((spreadsheet.first_row + 1)..spreadsheet.last_row).each do |row|

      name = spreadsheet.row(row)[headers['Name']]
      vc_code = spreadsheet.row(row)[headers['VC']]
      mfg_code = spreadsheet.row(row)[headers['Mfg Code']]
      description = spreadsheet.row(row)[headers['Extended Description']]
      vendor = spreadsheet.row(row)[headers['Vendor']]
      price = spreadsheet.row(row)[headers['Price']]
      category = spreadsheet.row(row)[headers['Category']]

      product = Product.find_by_name(name)
      if product.present?
      else
        prod = Product.new
        prod.name = name.nil? ? '' : name
        prod.vc_code = vc_code.nil? ? '' : vc_code
        prod.mfg_code = mfg_code.nil? ? '' : mfg_code
        prod.description = description.nil? ? '' : description
        prod.vendor_id = Vendor.find_by_name(vendor).present? ? Vendor.find_by_name(vendor).id : 0
        prod.price = price.nil? ? '' : price
        prod.category_id = Category.find_by_name(category).present? ? Category.find_by_name(category).id : 0

        prod.save
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

  def default_attributes
    StyleAttribute.where(:product_id => self.id).first
  end

  def convert_dynamic_fields
    if self.dynamic_fields.present? && !self.dynamic_fields.nil?
      self.dynamic_fields.gsub("=>", ":")
    else
      ''
    end
  end

  private

  def check_for_associations
    if inventories.any? || order_entries.any? || vendors_products.any? || orders.any?
      throw(:abort)
    end
  end

end
