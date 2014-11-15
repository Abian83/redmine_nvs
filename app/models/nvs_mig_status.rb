class NvsMigStatus < ActiveRecord::Base
  attr_accessible :description, :is_default, :name, :project_id, :main_process

  as_enum :m_process,  {EXPORT: 1, IMPORT: 2, XXXX: 3}, :prefix => 'm_process'

  before_save :only_one_default


  #Only default status is allowed.
  def only_one_default

  	if self.is_default
  		unless self.new_record?
  			old_status = NvsMigStatus.find self.id
  			if old_status.is_default and (self.is_default == old_status.is_default)
  				return true #it was already default
  			else
  			  	if NvsMigStatus.where(:is_default => true , :project_id => self.project_id).count > 0
  					self.errors.add(:is_default,'there is already one default migration status')
  					return false
  				end
  			end
  		else
  			if NvsMigStatus.where(:is_default => true , :project_id => self.project_id).count > 0
  				self.errors.add(:is_default,'there is already one default migration status')
  				return false
  			end
  		end
  	end

  end

end
