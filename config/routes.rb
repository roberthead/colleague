Rails.application.routes.draw do
  resource :landing, only: :show

  root "landings#show"
end
