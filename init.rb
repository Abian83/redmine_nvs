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
    permission :edit_nvs_subsystems, :nvs_subsystems => [:edit,:new,:create,:destroy]
  end

end
