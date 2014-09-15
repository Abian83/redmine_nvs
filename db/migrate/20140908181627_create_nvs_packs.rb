class CreateNvsPacks < ActiveRecord::Migration
  def change

      t.string :name, :limit => 30
      t.string :description, :default => "", :null => false
      # pack owner
      t.integer :nvs_dept_id, :null => false
      # status: new-requested-approved-moving-finished...
      t.integer :nvs_pack_status_id
      # environment associated to the pack
      t.integer :nvs_env_id, :null => false
      # pack type: R-Regular; E-Emergency; S:Synchro
      t.integer :nvs_pack_type_id, :null => false
      # Onwer
      t.integer :owner_id, :default => 0, :null => false
      # auditory
      t.datetime :updated_on
      t.integer :updated_by_id, :default => 0, :null => false
      # project
      t.integer :project_id, :null => false
    end



    #NVS_PACKS
    create_table :nvs_packs do |t|
      t.string  :name , :limit => 30
      t.integer :status
      t.integer :x_id
      t.string :x_type
      t.integer :nvs_env_id
      t.string :emergencies
      t.string :audit
      t.integer :project_id

      t.timestamps
    end


    #NVS_PACKS_PACKS
    create_table :nvs_packs_packs do |t|
      t.integer :x_id
      t.integer :y_id
      t.integer :rel_type
      t.integer :project_id

      t.timestamps
    end

    #NVS_LCS
    create_table :nvs_lcs do |t|
      t.integer :x_id
      t.integer :y_id
      t.integer :rel_type
      t.integer :project_id

      t.timestamps
    end

    #NVS_TYPES
    create_table :nvs_types do |t|
      t.string  :name
      t.string  :description
      t.timestamps
    end

    #NVS_TYPES
    create_table :nvs_pack_goals do |t|
      t.string  :nvs_goal_id
      t.string  :description
      t.timestamps
    end




  end
end
