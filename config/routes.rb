Rails.application.routes.draw do
  get "books/index"
  get "books/show"
  resource :session
  resources :passwords, param: :token
  resources :books, only: [ :index, :show ]

  root to: "books#index"
end
