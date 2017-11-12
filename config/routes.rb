Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # root "parties#new"
  root "welcome#welcome"

  resources :parties, only: [:show, :new, :create]
  get "parties/:id/create_giftings" => "parties#create_giftings"
  get "parties/:id/create_giftings_families" => "parties#create_giftings_families"
  post "parties/find" => "parties#find"

  resources :participants, only: [:create, :edit, :update]
  patch "participants/:id/update_preferences" => "participants#update_preferences"
  get "/participants/success" => "participants#success"

  get "/giftings/:id/remind" => "giftings#remind"

  get "confirm/:confirm_token" => "giftings#confirm"

  get "/parties/:id/santas_list_confirm" => "parties#santas_list_confirm"
  get "/parties/:id/santas_list" => "parties#santas_list"
  get "/parties/:id/group_families" => "parties#group_families"

  resources :families, only: [:new, :create, :edit]
end
