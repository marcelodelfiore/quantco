Rails.application.routes.draw do

  root 'static_pages#index'
  devise_for :users

  authenticate :user do
    resources :pairs, only: [:index] do
      collection do
        match 'search' => 'pairs#search', via: [:get, :post], as: :search
      end
    end

    resources :gaarch, only: [:index] do
      collection do
        match 'search' => 'gaarch#search', via: [:get, :post], as: :search
      end
    end

  end
    
  resources :residues, only: [:show]
  
end
