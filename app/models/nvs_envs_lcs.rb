class NvsEnvsLcs < ActiveRecord::Base
  attr_accessible :nvs_env_id, :field, :old_value, :end_value, :updated_by

  belongs_to :updated_by , :class_name => 'User', :foreign_key => 'updated_by'
end