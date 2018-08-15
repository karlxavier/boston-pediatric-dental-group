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
#  dynamic_fields       :string
#  specs                :text
#  vendor_quote_prices  :text
#  notes                :text
#

class Product < ApplicationRecord
  has_many :style_attributes
  has_many :item_messages

  has_many :order_entries
  has_many :orders, through: :order_entries

  has_many :chatroom_orders, through: :order_entries

  has_attached_file :picture, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment_content_type :picture, content_type: /\Aimage\/.*\z/

  def specs_html
    self.specs.to_s.gsub("\n", "<").gsub("<", "<br/>").html_safe
  end
  def vendor_quote_prices_html
    self.vendor_quote_prices.to_s.gsub("\n", "<").gsub("<", "<br/>").html_safe
  end
  def notes_html
    self.notes.to_s.gsub("\n", "<").gsub("<", "<br/>").html_safe
  end

  def convert_dynamic_fields
    if self.dynamic_fields.present? && !self.dynamic_fields.nil?
      self.dynamic_fields.gsub("=>", ":")
    else
      ''
    end
  end

  def get_html_safe_fields
    @dyna_fields = ''
    eval(self.dynamic_fields).each {|key, value| @dyna_fields = @dyna_fields + "#{key}: #{value}<br/>" }
    @dyna_fields
  end

  def picture_url
    @url = "http://www.stampready.net/dashboard/editor/user_uploads/image_uploads/2018/04/17/R3H4Mxn2s0SmpFj9lvtXDBzNkP8bfJqQ.jpg"
    if self.picture.exists?
      @url = self.picture.url
    end
    @url
  end

  def category_name
    if self.category.present?
      Category.find(self.category).name
    end
  end
end
