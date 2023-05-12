Rails.application.routes.draw do
  get "profile_names/show"
  get "profile_names/edit"
  get "profile_names/update"
  get "profiles/show"
  devise_for :users

  resource :landing

  resource :profile

  resources :resumes
  get "/resume", to: "resumes#show"

  root "landings#show"
end
