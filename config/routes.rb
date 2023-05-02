Rails.application.routes.draw do
  devise_for :users
  resource :landing, only: :show

  root "landings#show"
end
