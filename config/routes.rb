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

  # authentication
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  post '/logout', to: 'sessions#destroy'
end
