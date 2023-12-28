Rails.application.routes.draw do
  resources :employees
  resources :employee_attendances

  namespace :admin do
    resources :attendances
    post 'salaries/calculate', to: 'salaries#calculate'
    get 'salaries/employee/:id', to: 'salaries#show_employee_salary'
  end

  post '/login', to: 'authentication#login'
end
