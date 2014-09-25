class NvsEnvsLcs < ActiveRecord::Base
  attr_accessible :nvs_env_id, :field, :old_value, :end_value
end