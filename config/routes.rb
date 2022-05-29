Rails.application.routes.draw do
  devise_for :users,
    controllers: {
      passwords: 'devise/passwords',
      sessions: 'devise/sessions'
    },
    skip: [:registrations]

  scope '/administration', module: 'administration', as: 'administration' do
    resources :congregateds, except: [:delete, :destroy]
    resources :churches, except: [:delete, :destroy]
    resources :jobs, except: [:delete, :destroy]
    resources :posts, except: [:delete, :destroy]
    resources :members, except: [:delete, :destroy]

    resources :countries, except: [:delete, :destroy] do
      resources :states, except: [:delete, :destroy] do
        resources :cities, except: [:delete, :destroy]
      end
    end

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
    resources :inventories, except: :destroy
  end

  root to: 'home#index'

  get 'addresses/post_offices_address/:zipcode', to: 'addresses#post_offices_address'

  get '*a', to: 'application#render_error'
end
