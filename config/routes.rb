Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  root "parties#new"

  resources :parties, only: [:show, :new, :create]
  get "parties/:id/create_giftings" => "parties#create_giftings"
  resources :participants, only: [:create, :edit, :update], param: :confirm_token

  get "confirm/:confirm_token" => "giftings#confirm"

  get "/participants/success" => "participants#success"

end
