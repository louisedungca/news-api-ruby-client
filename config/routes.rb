Rails.application.routes.draw do
  root "news#index"

  resources :news, only: [:index]
end
