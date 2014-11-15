class NvsMigProcess < ActiveRecord::Base

	attr_accessible :description, :name, :nvs_action, :nvs_action_sequence,  :nvs_main_process, :nvs_mig_status_id, :nvs_process_sequence, :target_env_c, :target_env_p, :target_env_t
	
	as_enum :actiontype, {JCL: 1, KSH: 2, CMD: 3, MAN: 4}, :prefix => 'actiontype'
 
	belongs_to :nvs_mig_status
end
