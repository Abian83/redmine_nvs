class NvsMigProcess < ActiveRecord::Base
  attr_accessible :description, :name, :nvs_action, :nvs_action_sequence, :nvs_action_type, :nvs_action_type, :nvs_main_process, :nvs_mig_status_id, :nvs_process_sequence, :target_env_c, :target_env_p, :target_env_t
end
