Rails.application.routes.draw do
  resources :employees
  resources :employee_attendances

  namespace :admin do
    resources :attendances
  end


  post '/login', to: 'authentication#login'
end
