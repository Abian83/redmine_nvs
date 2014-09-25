class NvsMig < ActiveRecord::Base
  attr_accessible :end_date, :init_date, :name, :nvs_action_sequence, :nvs_mig_status_id, :nvs_process_sequence, :project_id, :source_env_id, :target_env_id
end
