class CreateNvsEnvs < ActiveRecord::Migration
  def change
    create_table :nvs_envs do |t|
      t.string :name
      t.string :description
      t.integer :mayor_rle
      t.integer :minor_rle
      t.integer :sequence
      t.integer :type_id
      t.text :repositories
      t.text :runtime
      t.text :subsystems
      t.integer :project_id

      t.timestamps
    end

    create_table :nvs_envs_lcs do |t|
      t.string :field
      t.text :old_value
      t.text :new_value
      t.timestamps
    end

  end

end
