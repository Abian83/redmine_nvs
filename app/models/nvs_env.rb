class NvsEnv < ActiveRecord::Base
  attr_accessible :mayor_rle, :minor_rle, :name, :description, :project_id, :repositories, :runtime, :sequence, :subsystems, :type_id

  	validates :name,:description, length: { maximum:150,
    too_long: "%{count} characters is the maximum allowed" }, :presence => true
    validates :mayor_rle,:minor_rle , :presence => true

	belongs_to :project
	has_many :nvs_envs_lcss

	before_save :check_rle,:check_sequence, :check_texts, :change_history

	as_enum :type,  {DEVELOPMENT: 0, TRANSIT: 1, CERTIFICATION: 2 ,PRODUCTION:3}, :prefix => 'type'

	# Check that mayor_rle > minor_rle , and set minor_rle=0 if mayor_rls has been changed.
	def check_rle
		unless self.new_record?
			old_mayor_rle = NvsEnv.find(self.id).mayor_rle
			if old_mayor_rle != self.mayor_rle
				self.minor_rle = 0 #reset minor version if mayor have been changed
			  return true
			end
		end

		if self.mayor_rle < self.minor_rle
			self.errors.add(:temp_start_date,'mayor_rle must be > than minor_rle')
			return false
		end
	end


	def check_sequence
		return true
	end


	def check_texts
		verify_sintax(self.repositories, :repositories) unless self.repositories.nil?
		verify_sintax(self.runtime, :runtime)			unless self.runtime.nil?
		verify_sintax(self.subsystems, :subsystems)		unless self.subsystems.nil?	
	end



	def verify_sintax(field,field_name)
		field.split("\r\n").each_with_index do |line,idx|
			if /^;/.match(line) || /^[[:word:]]+=\S([[:ascii:]]|[[:word:]])*/.match(line) || /^\[[[:word:]]+\]$/.match(line)
				next
			else
				self.errors.add(field_name,'Bad format in line '  + (idx+1).to_s)
			end
		end
		return ! (self.errors.any?)
	end


	def change_history
		unless self.new_record?
			old_env = NvsEnv.find(self.id)
			[:mayor_rle,:minor_rle,:subsystems,:runtime,:repositories,:type_id,:sequence].each do |field|
				if old_env[field] != self[field]
					nvs_env_lcs = NvsEnvsLcs.new
					nvs_env_lcs.nvs_env_id = self.id
					nvs_env_lcs.field = field
					nvs_env_lcs.old_value = old_env[field]
					nvs_env_lcs.new_value = self[field]
					nvs_env_lcs.updated_by = User.current
					nvs_env_lcs.save
				end
				
			end			

		end
	end

end
