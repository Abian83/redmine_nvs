class NvsDeptUser < ActiveRecord::Base
  attr_accessible :authorization_level, :nvs_dept_id, :project_id, :temp_authorization_level, :temp_end_date, :temp_start_date, :user_id

  belongs_to :project
  belongs_to :user
  belongs_to :nvs_dept

  before_save :check_temp_dates

  validates :user_id, :uniqueness => true

  as_enum :level,      {REGULAR: 1, SENIOR: 2, BOSS: 3}, :prefix => 'level'
  as_enum :temp_level, {REGULAR: 1, SENIOR: 2, BOSS: 3}, :prefix => 'tmplevel'


  def check_temp_dates
    if self.temp_start_date > self.temp_end_date
      self.errors.add(:temp_start_date,'start date must be < than end date')
      return false
    else
      return true
    end
  end

end
