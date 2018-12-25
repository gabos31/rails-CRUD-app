Rails.application.routes.draw do
  get 'welcome/index'

  root 'welcome#index'

  resource :session, only: %i[new create destroy]

  resources :users do
    member do
      get 'edit_password'
      patch 'edit_password', to: 'users#update_password'
    end
  end

  resolve('Session') { route_for(:session) }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
