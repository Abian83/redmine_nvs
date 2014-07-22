class CreateNvsSubsystems < ActiveRecord::Migration
  def change
    create_table :nvs_subsystems do |t|
      t.string :name
      t.string :internal_name, limit: 7
      t.integer :project_id
    end
  end
end
