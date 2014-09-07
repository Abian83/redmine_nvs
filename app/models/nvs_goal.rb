class NvsGoal < ActiveRecord::Base
  attr_accessible :created_by_id, :created_on, :description, :ext_goal_reference, :nvs_goal_type_id, :project_id

  belongs_to :nvs_goal_type
  belongs_to :project
  belongs_to :created_by , :class_name => 'User', :foreign_key => 'created_by_id'

  validates_uniqueness_of :nvs_goal_type_id , :scope => [:ext_goal_reference]

end
