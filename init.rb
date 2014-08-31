require 'redmine'

#require_dependency 'main_hook'

Redmine::Plugin.register :redmine_nvs do
  name 'Redmine Nvs plugin'
  author 'Abian Marrero'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'


  menu :project_menu, :redmine_nvs, { :controller => 'nvs_subsystems', :action => 'index' }, :caption => 'NVS', :after => :activity, :param => :project_id


  project_module :redmine_nvs do

    permission :view_nvs_subsystems, :nvs_subsystems => [:index, :show]
    permission :edit_nvs_subsystems, :nvs_subsystems => [:edit,:new,:create,:destroy,:update]

    permission :view_nvs_dept_projects, :nvs_dept_projects => [:index, :show]
    permission :edit_nvs_dept_projects, :nvs_dept_projects => [:edit,:new,:create,:destroy,:update]

    permission :view_nvs_depts, :nvs_depts => [:index, :show]
    permission :edit_nvs_depts, :nvs_depts => [:edit,:new,:create,:destroy,:update, :users2dept]

    permission :view_nvs_dept_users, :nvs_dept_users => [:index, :show]
    permission :edit_nvs_dept_users, :nvs_dept_users => [:edit,:new,:create,:destroy,:update]

  end

end
