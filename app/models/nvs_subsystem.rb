class NvsSubsystem < ActiveRecord::Base
  validates :internal_name, length: { maximum: 7,
    too_long: "%{count} characters is the maximum allowed" }, :presence => true
  belongs_to :project

  validates_uniqueness_of :name, :scope => [:name, :internal_name]
end
