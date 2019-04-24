# == Schema Information
#
# Table name: users
#
#  id                     :bigint(8)        not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  roles_mask             :integer
#  admin                  :boolean
#  billing_address        :integer
#  shipping_address       :integer
#  first_name             :string
#  last_name              :string
#  brand_id               :bigint(8)
#  group_id               :bigint(8)
#  mobile                 :string
#  notes                  :text
#  active                 :boolean
#  title                  :string
#  phone                  :string
#  customer_id            :integer
#  vendor_id              :integer
#  last_notified          :datetime
#

class User < ApplicationRecord
  #belongs_to :shipping_address, :class_name => 'Address', :foreign_key => 'shipping_address'
  #belongs_to :billing_address, :class_name => 'Address', :foreign_key => 'billing_address'
  
  audited except: [:last_notified, :updated_at, :last_notified, :last_sign_in_at, :last_sign_in_ip, :sign_in_count, :current_sign_in_at, :current_sign_in_ip]

  has_associated_audits

  has_many :brands
  has_many :groups
  has_many :orders
  has_many :users_brands
  has_many :user_time_logs
  has_many :users_group_details
  has_many :users_groups, through: :users_group_details

  has_many :channel_users
  has_many :channels, through: :channel_users

  has_many :document_shares
  has_many :document_uploads, through: :document_shares

  # has_many :comms, class_name: 'OrderUser', primary_key: 'id', foreign_key: 'comms'
  # has_many :chatroom_orders, through: :comms

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many :products

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :email, presence: true

  before_destroy :check_for_associations

  ROLES = %i[admin product_manager sales_manager views_only]

  def roles=(roles)
    roles = [*roles].map { |r| r.to_sym }
    self.roles_mask = (roles & ROLES).map { |r| 2**ROLES.index(r) }.inject(0, :+)
  end

  def roles
    ROLES.reject do |r|
      ((roles_mask.to_i || 0) & 2**ROLES.index(r)).zero?
    end
  end

  def has_role?(role)
    roles.include?(role)
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

  def full_name
    "#{first_name} #{last_name}"
  end

  private

    def check_for_associations
        if brands.any? || groups.any? || users_brands.any?
          throw(:abort)
        end
    end

end
