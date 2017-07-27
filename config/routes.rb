Rails.application.routes.draw do
  devise_for :users

  resources :recipes do
    collection do
      get 'search'
    end
    member do
      put "like", to: "recipes#upvote"
      put "dislike", to: "recipes#downvote"
    end
  end

  root to: "recipes#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
