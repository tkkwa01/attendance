Rails.application.routes.draw do
  resources :employees
  resources :employee_attendances

  post '/login', to: 'authentication#login'
end
