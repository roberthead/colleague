Rails.application.routes.draw do
  devise_for :users

  resource :landing, only: :show
  resource :resume, only: :show

  resources :resumes

  root "landings#show"
end
