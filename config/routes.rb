Rails.application.routes.draw do
  root 'places#index'
  resources :places

  get 'distancias' => 'directions#distance'
  get 'paths' => 'directions#paths'
end
