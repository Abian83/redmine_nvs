class NvsDeptUser < ActiveRecord::Base
  attr_accessible :authorization_level, :nvs_dept_id, :project_id, :temp_authorization_level, :temp_end_date, :temp_start_date, :user_id

  belongs_to :project
  belongs_to :user

  validates :user_id, :uniqueness => true

  as_enum :level,      {REGULAR: 1, SENIOR: 2, BOSS: 3}, :prefix => 'level'
  as_enum :temp_level, {REGULAR: 1, SENIOR: 2, BOSS: 3}, :prefix => 'tmplevel'

end
