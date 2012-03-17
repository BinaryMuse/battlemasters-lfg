Battlemasters::Application.routes.draw do
  resources :listings
  resources :icons, only: :index
  root to: "listings#index"
end
