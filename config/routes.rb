Rails.application.routes.draw do
  resources :roles
  devise_for :users

  resource :landing

  resource :profile

  resources :resumes do
    resources :employers
  end

  get "/resume", to: "resumes#show"

  root "landings#show"
end
