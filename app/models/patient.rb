class Patient < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :document_shares
  has_many :document_uploads, through: :document_shares

  has_many :patient_shared_files

  belongs_to :office

  scope :patients_with_shared_files, -> { includes(:patient_shared_files).where.not(patient_shared_files: {id: nil}) }

  protected
    def password_required?
      confirmed? ? super : false
    end

end
