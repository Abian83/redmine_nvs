class NvsMig < ActiveRecord::Base
  attr_accessible :end_date, :init_date, :name, :nvs_action_sequence, :nvs_mig_status_id, :nvs_process_sequence, :project_id, :source_env_id, :target_env_id
  
  belongs_to :project
  belongs_to   :source_env , :class_name => 'NvsEnv' , :foreign_key => 'source_env_id'
  belongs_to   :target_env , :class_name => 'NvsEnv' , :foreign_key => 'target_env_id'
  belongs_to   :nvs_mig_status , :class_name => 'NvsMigStatus' , :foreign_key => 'nvs_mig_status_id'
end
