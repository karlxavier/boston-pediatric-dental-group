class Office < ApplicationRecord
     has_many :patients
     has_many :products
     has_many :order_offices
     has_many :orders, through: :order_offices
end
