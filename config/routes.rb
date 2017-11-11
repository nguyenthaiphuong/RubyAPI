Rails.application.routes.draw do

  #devise_for :users
  mount_devise_token_auth_for 'User', at: 'auth', controllers: {
    token_validations:  'overrides/token_validations',
    sessions: 'overrides/sessions'
  }

  api_version(:module => "V1", :path => {:value => "v1"}, :default => true) do
    resources :time_requests
    resources :ots
    resources :roles
    resources :projects
    resources :users
    resources :depts
    resources :positions
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
