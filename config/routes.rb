Rails.application.routes.draw do
  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    root 'places#index'
    resources :places
    resources :sessions
    resources :users
    
    get 'distancias' => 'directions#distance'
    get 'caminhos' => 'directions#paths'
    # get 'melhor_caminho' => 'directions#best_path'
  end

  get '*path', to: redirect("/#{I18n.default_locale}/%{path}")
  get '', to: redirect("/#{I18n.default_locale}")
end
