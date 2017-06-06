Rails.application.routes.draw do
  devise_for :users,
             controllers: {
               passwords: 'devise/passwords',
               sessions: 'devise/sessions'
             },
             skip: [:registrations]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  scope '/administration', module: 'administration', as: 'administration' do
    resources :countries
    resources :states
    resources :cities

    resources :users, except: [:delete, :destroy] do
      resources :permits, only: [:index, :new] do
        collection do
          post :save_changes
        end
      end

      collection do
        get :reset_password
      end
    end

    resources :user_profiles, only: [:edit, :update] do
      member do
        get :unlock
        patch :update_unlock_attributes
      end
    end
  end

  scope '/patrimony', module: 'patrimony', as: 'patrimony' do
    resources :stocks, except: :destroy
  end

  root to: 'home#index'
  get '*a', to: 'application#render_error'
end
