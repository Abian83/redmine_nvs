class NvsPack < ActiveRecord::Base
  attr_accessible :audit, :emergencies, :name, :nvs_env_id, :project_id, :status, :x_id, :x_type
end
