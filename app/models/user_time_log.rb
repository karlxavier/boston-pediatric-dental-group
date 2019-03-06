class UserTimeLog < ApplicationRecord
    belongs_to :user
    belongs_to :office_time_log

    # validates :time_in, uniqueness: true
    validates_uniqueness_of :time_in, scope: %i[user_id description]

    audited associated_with: :user

    scope :get_active_time_in, -> (user_id) { includes(:user).where(user_id: user_id, active: true) }
    scope :group_logs, -> (user_id) { UserTimeLog.where(user_id: user_id).group("time_in::date").order("time_in::date DESC").sum(:duration)}
    scope :log_details, -> (user_id, time_in) { UserTimeLog.where("user_id = ? AND time_in::date = ?", user_id, time_in).where('duration IS NOT NULL AND time_in IS NOT NULL AND time_out IS NOT NULL ').order("time_in DESC") }

    scope :all_active_logs, -> { includes(:user, :office_time_log).limit(500) }
    scope :admin_filter_timelogs, -> (from_date, to_date) { includes(:user, :office_time_log).where("DATE(time_in) BETWEEN ? AND ?", from_date, to_date) }
    scope :user_filter_timelogs, -> (user_id, from_date, to_date) { includes(:user, :office_time_log).where(user_id: user_id).where("DATE(time_in) BETWEEN ? AND ?", from_date, to_date) }
    scope :dashboard_latest_logs, -> (date) { includes(:user).select("DISTINCT ON (user_id) *").where("DATE(time_in) = ?", date)  }
    scope :user_time_log, -> (date, user_id) { includes(:user).where("DATE(time_in) = ?", date).where(user_id: user_id)  }

    require 'csv'

    def self.import(file)
        spreadsheet= open_spreadsheet(file)
        spreadsheet.default_sheet = spreadsheet.sheets[0]

        headers = Hash.new
        spreadsheet.row(1).each_with_index {|header,i|headers[header] = i}
        ((spreadsheet.first_row + 1)..spreadsheet.last_row).each do |row|
            
            date = spreadsheet.row(row)[headers['Date']]
            timein = spreadsheet.row(row)[headers['Timein']]
            timeout = spreadsheet.row(row)[headers['Timeout']]
            office = spreadsheet.row(row)[headers['Office']]
            employee = spreadsheet.row(row)[headers['Employee']]

            if !employee.nil? && !timein.nil? && !timeout.nil?

                utl = UserTimeLog.new
                
                utl.description = office
                utl.time_in = timein
                utl.time_out = timeout
                utl.user_id = User.where(first_name: employee).first.id
                utl.office_time_log_id = OfficeTimeLog.where(name: office).first.id
                utl.active = false
                # utl.duration = (DateTime.parse(timeout).stftime("%Y-%-m-%d %H:%M:%S") - DateTime.parse(timein).stftime("%Y-%-m-%d %H:%M:%S")).to_i

                utl.save

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

end
