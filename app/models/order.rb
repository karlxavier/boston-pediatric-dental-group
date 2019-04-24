class Order < ApplicationRecord
     belongs_to :user
     belongs_to :vendor
     has_many :order_offices
     has_many :offices, through: :order_offices
     has_many :order_products, dependent: :destroy
     has_many :products, through: :order_products
     has_many :order_attachments

     accepts_nested_attributes_for :order_products,
                                   allow_destroy: true,
                                   reject_if: :all_blank

     accepts_nested_attributes_for :order_attachments,
                                   allow_destroy: true,
                                   reject_if: :all_blank     

     # enum status: ["New", "Processed", "Received", "Cancel"]
     enum status: [:new_order, :processed, :received, :cancel]

     before_save :update_net_amount
       
     scope :scope_orders, -> { includes(:order_products, :order_attachments, :order_offices, :offices, :vendor, :products, :user).order(id: :desc) }
     scope :scope_filter_orders, -> (status, from_date, to_date) { includes(:order_products, :order_attachments, :order_offices, :offices, :vendor, :products, :user)
                                                                 .where("DATE(created_at) BETWEEN ? AND ?", from_date, to_date)
                                                                 .where(status: status)
                                                                 .order(id: :desc) }

     def net_amount    
          order_products.collect { |oi| oi.valid? ? (oi.quantity * oi.amount) : 0 }.sum
     end

     def total_amount
          net_amount
     end

     private

     def update_net_amount
          self[:total_amount] = total_amount
     end

end
