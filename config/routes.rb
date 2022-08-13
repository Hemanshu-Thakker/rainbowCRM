Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'leads#index'
  resource :leads
  resource :customers

  get '/admin_dashboard', to: 'customers#index'
end
