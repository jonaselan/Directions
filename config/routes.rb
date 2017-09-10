Rails.application.routes.draw do
  scope ":locale", locale: /#{I18n.available_locales.join("|")}/ do
    root 'places#index'

    get 'signup', to: 'users#new', as: 'singup'
    get 'login', to: 'sessions#new', as: 'login'
    delete 'logout', to: 'sessions#destroy', as: 'logout'

    resources :places
    resources :sessions
    resources :users

    get 'distances' => 'directions#distance'
    get 'paths' => 'directions#paths'
    # get 'melhor_caminho' => 'directions#best_path'
  end

  get '*path', to: redirect("/#{I18n.default_locale}/%{path}")
  get '', to: redirect("/#{I18n.default_locale}")
end
