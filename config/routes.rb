Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'leads#index'
  resource :leads
  resource :customers

  get '/dashboard', to: 'application#dashboard'
  post '/leads/update/status', to: 'leads#update_status_complete', as: "lead_update_status"
  post '/lead_generation', to: 'leads#lead_generation'
  get '/leads/generate', to: 'application#export'
  get '/website_leads', to: 'leads#website_leads', as: "website_leads"
  post '/update/assigned_to', to: 'leads#update_assigned_to', as: "update_assigned_to"
  get 'search/tickets', to: 'leads#find'
  post 'search/tickets', to: 'leads#find_filter'
  get 'customers/index', to: 'customers#index'
  post 'customers/fetch', to: 'customers#fetch_customer'
  get '/work/index', to: 'application#work_index'

  # authentication
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
end
