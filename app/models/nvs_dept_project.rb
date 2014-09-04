class NvsDeptProject < ActiveRecord::Base
  attr_accessible :internal_name, :name, :nvs_dept_id, :nvs_subsystem_id, :project_id

  validates :name, length: { maximum: 10,
    too_long: "%{count} characters is the maximum allowed" }, :presence => true

  validates :internal_name, length: { maximum: 5,
     too_long: "%{count} characters is the maximum allowed" }, :presence => true

  validates :project_id, presence: true
  validates_uniqueness_of :name, :scope => :internal_name

  belongs_to :project
  belongs_to :nvs_subsystem
  belongs_to :nvs_dept

end
