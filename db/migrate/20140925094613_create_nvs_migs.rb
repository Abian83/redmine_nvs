class CreateNvsMigs < ActiveRecord::Migration

  def change

    create_table :nvs_migs do |t|
      t.string :name
      t.datetime :end_date
      t.datetime :init_date
      t.integer  :nvs_mig_status_id
      t.integer  :source_env_id
      t.integer  :target_env_id
      t.string   :nvs_process_sequence
      t.string   :nvs_action_sequence
      t.integer :project_id

      t.timestamps
    end

    create_table :nvs_mig_statuses do |t|
      t.string  :name
      t.string  :description
      t.boolean :is_default
      t.integer :main_process
      t.integer :project_id
      t.timestamps
    end


    create_table :nvs_mig_processes do |t|
      t.string  :name
      t.string  :description
      t.integer :nvs_main_process
      t.string  :nvs_action
      t.integer :nvs_action_type
      t.integer :nvs_action_sequence
      t.integer :nvs_process_sequence
      t.boolean :target_env_t
      t.boolean :target_env_c
      t.boolean :target_env_p
      t.integer :nvs_mig_status_id
    end

  end
end
