Rails.application.routes.draw do

  post 'login', to: 'session#create'
  resources :personnel, only: [:index, :create, :show, :update, :destroy]
  resources :reimbursement, only: [:index, :create, :show, :update, :destroy]

end
