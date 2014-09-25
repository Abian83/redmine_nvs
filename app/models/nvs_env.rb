class NvsEnv < ActiveRecord::Base
  attr_accessible :mayor_rle, :minor_rle, :name, :name, :project_id, :repositories, :runtime, :sequence, :subsystems, :type_id

	belongs_to :project
	belongs_to :nvs_envs_lcs , :class_name => 'NvsEnvsLcs', :foreign_key => 'nvs_env_id'

	before_save :check_rle,:check_sequence, :check_texts, :journalize

	as_enum :type,  {D: 0, T: 1, C: 2 ,P:3}, :prefix => 'type'

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
			#avoid comments
			if /^;/.match(line) || /^[[:word:]]+=\"[[:ascii:]]+\"/.match(line) || /^[[:word:]]+=\S[[:ascii:]]+/.match(line) || /^\[[[:word:]]+\]$/.match(line)
				next
			else
				self.errors.add(field_name,'Bad format in line '  + (idx+1).to_s)
			end
		end

		if self.errors.any?
			return false
		end

		
		return true

	end

	def journalize
		unless self.new_record?
			old_env = NvsEnv.find(self.id)
			[:mayor_rle,:minor_rle,:subsystems,:runtime,:repositories,:type_id,:sequence].each do |field|
				if old_env[field] != self[field]
					nvs_env_lcs = NvsEnvsLcs.new
					nvs_env_lcs.nvs_env_id = self.id
					nvs_env_lcs.field = field
					nvs_env_lcs.old_value = old_env[field]
					nvs_env_lcs.new_value = self[field]
					nvs_env_lcs.save
				end
				
			end			

		end
	end

end
