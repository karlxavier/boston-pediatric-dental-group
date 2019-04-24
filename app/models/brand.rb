# == Schema Information
#
# Table name: brands
#
#  id         :bigint(8)        not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#

class Brand < ApplicationRecord

	audited

	# has_many :orders
	has_many :hotels
	has_many :users_brands
	has_many :customers
	has_many :order_branches

	validates :name, presence: true
	validates :name, uniqueness: true

	before_destroy :check_for_associations

	extend FriendlyId
  	friendly_id :name, use: [:slugged, :finders]

  	def should_generate_new_friendly_id?
	 	name_changed?
	end

	private

	    def check_for_associations
	      	if orders.any? || hotels.any? || users_brands.any? || customers.any? || order_branches.any?
	        	throw(:abort)
	      	end
	    end
	
end
