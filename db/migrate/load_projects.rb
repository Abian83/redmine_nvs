require 'csv'

file = '/home/bitnami/apps/redmine/htdocs/db/migrate/projects.csv'

def load_projects(file='/Users/abian_pro/redmine-2.5/plugins/redmine_nvs/db/migrate/projects.csv')
  #csv_text = File.read(File.dirname(__FILE__) + '/Users/abian_pro/redmine-2.5/plugins/redmine_nvs/db/migrate/projects.csv')
  csv_text = File.read(file)
  csv = CSV.parse(csv_text, :headers => true)
  csv.each do |row|
    p = NvsDeptProject.new
    values = (row.to_s.delete!("\n")).split(";")
    p.name = values[0]
    p. internal_name = values[1]
    p.project = Project.find("1")
    p.nvs_subsystem_id = 0
    p.nvs_dept_id = 0
    if p.save
      puts "importado #{values[0]} - #{values[0]} "
    else
      puts "Fallo imporranto #{values[0]} - #{values[0]} "
    end
  end
end
