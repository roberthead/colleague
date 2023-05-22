Rails.application.routes.draw do
  devise_for :users

  resource :landing

  resource :profile

  resources :resumes do
    resources :employers
    resources :schools
  end

  get "/resume", to: "resumes#show"

  if ENV["LANDING_PAGE_REDIRECT"].present?
    root to: redirect(ENV["LANDING_PAGE_REDIRECT"], status: 302)
  else
    root "landings#show"
  end
end
