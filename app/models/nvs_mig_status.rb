class NvsMigStatus < ActiveRecord::Base
  attr_accessible :description, :is_default, :main_process, :name, :project_id
end
