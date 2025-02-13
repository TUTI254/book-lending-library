Rails.application.routes.draw do
  resources :books, only: [ :index, :show ]

  resources :borrowings, only: [ :index, :create ] do
    member do
      patch :return
    end
  end

  # Authentication routes
  delete "/logout", to: "sessions#destroy", as: :logout
  resource :session, only: [ :new, :create ]
  resource :passwords, only: [ :new, :create, :edit, :update ]

  root "books#index"
end
