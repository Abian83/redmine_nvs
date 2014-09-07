class CreateNvsGoals < ActiveRecord::Migration
  def change
    create_table :nvs_goals do |t|
      t.string :ext_goal_reference
      t.string :description
      t.integer :nvs_goal_type_id
      t.datetime :created_on
      t.integer :created_by
      t.integer :project_id

      t.timestamps
    end
  end
end
