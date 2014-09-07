class NvsGoalType < ActiveRecord::Base
  attr_accessible :created_by_id, :created_on, :description, :free_goal, :name, :sql_connect, :sql_access

  belongs_to :created_by , :class_name => 'User', :foreign_key => 'created_by_id'
end
