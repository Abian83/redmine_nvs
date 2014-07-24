class NvsDept < ActiveRecord::Base
  attr_accessible :email, :name, :project_id

  validates :name, length: { maximum: 50,
    too_long: "%{count} characters is the maximum allowed" }, :presence => true

  validates :email, length: { maximum: 300,
     too_long: "%{count} characters is the maximum allowed" }, :presence => true

  validates :project_id, presence: true

  belongs_to :project

end
