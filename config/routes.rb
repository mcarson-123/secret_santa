Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # root "parties#new"
  root "welcome#welcome"

  resources :parties, only: [:show, :new, :create]
  get "parties/:id/create_giftings" => "parties#create_giftings"
  post "parties/find" => "parties#find"

  resources :participants, only: [:create, :edit, :update]
  patch "participants/:id/update_preferences" => "participants#update_preferences"

  get "confirm/:confirm_token" => "giftings#confirm"

  get "/participants/success" => "participants#success"

end
