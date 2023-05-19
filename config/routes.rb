Rails.application.routes.draw do
  devise_for :users

  resource :landing

  resource :profile

  resources :resumes do
    resources :employers
    resources :schools
  end

  get "/resume", to: "resumes#show"

  root "landings#show"
end
