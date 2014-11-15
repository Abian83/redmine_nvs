# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html
#RedmineNvs::Application.routes.draw do
  resources :nvs_subsystems
  resources :nvs_mig_processes
  resources :nvs_mig_statuses
  resources :nvs_migs
  resources :nvs_envs
  resources :nvs_packs
  resources :nvs_goals
  resources :nvs_goal_types
  resources :nvs_dept_users

  resources :nvs_depts do
    collection do
      get 'users2dept'
    end
    member do
    end
  end

  #resources :nvs_depts
  resources :nvs_dept_projects
  resources :mains

#end
