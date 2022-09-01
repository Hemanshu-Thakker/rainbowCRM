Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'leads#index'
  resource :leads
  resource :customers

  get '/admin_dashboard', to: 'customers#index'
  post '/leads/update/status', to: 'leads#update_status_complete', as: "lead_update_status"
  post '/lead_generation', to: 'leads#lead_generation'
end
