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
  end

end
