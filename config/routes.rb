Rails.application.routes.draw do
  root 'places#index'
  resources :places

  get 'distancias' => 'directions#distance'
  get 'caminhos' => 'directions#paths'
  get 'melhor_caminho' => 'directions#best_path'
end
