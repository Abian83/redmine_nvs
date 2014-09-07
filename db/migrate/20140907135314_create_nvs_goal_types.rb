class CreateNvsGoalTypes < ActiveRecord::Migration
  def change
    create_table :nvs_goal_types do |t|
      t.string :name
      t.string :description
      t.string :sql_connect
      t.string :sql_access
      t.datetime :created_on
      t.integer :created_by
      t.boolean :free_goal

      t.timestamps
    end
  end
end
