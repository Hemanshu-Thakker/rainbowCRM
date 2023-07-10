Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'leads#index'
  resource :leads
  resource :customers

  get '/dashboard', to: 'application#dashboard'
  post '/leads/update/status', to: 'leads#update_status_complete', as: "lead_update_status"
  post '/lead_generation', to: 'leads#lead_generation'
  get '/leads/generate', to: 'application#export', as: "lead_generate_csv"
  get '/leads/generate_lead_data', to: 'application#export_lead_data'
  get '/website_leads', to: 'leads#website_leads', as: "website_leads"
  post '/update/assigned_to', to: 'leads#update_assigned_to', as: "update_assigned_to"
  get 'search/tickets', to: 'leads#find'
  post 'search/tickets', to: 'leads#find_filter'
  get 'customers/index', to: 'customers#index'
  get 'customers/fetch', to: 'customers#fetch_customer'
  delete 'customers/delete', to: 'customers#destroy', as: "customers_destroy"
  post 'customers/merge', to: 'customers#merge_customers'
  get '/customers/generate_customer_items_data', to: 'customers#export_customer_order_data'
  get '/work/index', to: 'application#work_index'

  # authentication
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
end
