Rails.application.routes.draw do
  resources :employees
  resources :attendances

  post '/login', to: 'authentication#login'
end
