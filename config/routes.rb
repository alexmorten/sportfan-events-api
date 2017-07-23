Rails.application.routes.draw do
  resources :links
  resources :tags
  resources :events
  resources :groups, except: :create do
    resources :groups, module: 'groups',except: [:show,:update,:destroy]
    resources :events, module: 'groups',only: :index
  end
  resources :users, except:[:create,:destroy] do
    resources :groups, module: 'users',except: [:show,:update,:destroy]
    resources :events, module: 'users',only: :index
  end
  get 'me',to: 'misc#me'

  mount_devise_token_auth_for 'User' , at: 'auth'





  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
