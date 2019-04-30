class OrderProduct < ApplicationRecord
     belongs_to :product
     belongs_to :order

     # before_save :finalize

     validates :product_id, presence: true

     enum status: ["New", "Received", "Cancel"]

     scope :new_orders, -> { where(status: 'New').order(id: :desc) }
     scope :received_orders, -> { where(status: 'Received').order(id: :desc) }

     private

     def finalize
          # self[:amount] = amount
          self[:net_amount] = quantity * self[:amount]
     end

end
