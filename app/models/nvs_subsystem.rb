class NvsSubsystem < ActiveRecord::Base
  validates :internal_name, length: { maximum: 2,
    too_long: "%{count} characters is the maximum allowed" }, :presence => true
  belongs_to :project
end
