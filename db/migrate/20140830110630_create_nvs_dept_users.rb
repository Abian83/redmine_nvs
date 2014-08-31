class CreateNvsDeptUsers < ActiveRecord::Migration
  def change
    create_table :nvs_dept_users do |t|
      t.integer :nvs_dept_id
      t.integer :user_id
      t.integer :authorization_level
      t.integer :temp_authorization_level
      t.integer :project_id
      t.datetime :temp_start_date
      t.datetime :temp_end_date

      t.timestamps
    end
  end
end
