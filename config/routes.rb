Rails.application.routes.draw do
  devise_for :users

  resource :landing, only: :show

  resources :resumes
  get "/resume", to: "resumes#show"

  root "landings#show"
end
