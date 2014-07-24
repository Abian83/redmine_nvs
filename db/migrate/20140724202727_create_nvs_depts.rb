class CreateNvsDepts < ActiveRecord::Migration
  def change
    create_table :nvs_depts do |t|
      t.string  :name,       :limit => 50, :default => "", :null => false
      t.string  :email,      :limit => 300, :default => "", :null => false
      t.integer :project_id, :null => false

      t.timestamps
    end
  end
end
