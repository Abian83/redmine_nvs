class CreateNvsDeptProjects < ActiveRecord::Migration
  def change
    create_table :nvs_dept_projects do |t|
      t.string :name,               :limit => 10, :default => "", :null => false
      t.integer :nvs_dept_id,       :null => false
      t.integer :project_id,        :null => false
      t.string :internal_name,      :limit => 5, :default => "", :null => false
      t.integer :nvs_subsystem_id,  :null => false
    end
  end
end
