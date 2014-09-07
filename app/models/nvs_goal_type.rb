class NvsGoalType < ActiveRecord::Base
  attr_accessible :created_by, :created_on, :description, :free_goal, :name, :sql_connect, :sql_access
end
