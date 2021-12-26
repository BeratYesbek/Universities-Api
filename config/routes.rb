Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #
  #
  namespace 'api' do
    resources :countries
    resources :cities
    resources :universities do
      collection do
        get 'get_by_country_name'
        get 'get_by_state_name'
        get 'get_by_city_name'
      end
    end
    resources :states
  end

end
