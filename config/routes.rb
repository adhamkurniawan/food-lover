Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users, path: "chefs"

  resources :recipes do
    collection do
      get 'search'
    end
    member do
      put "like", to: "recipes#upvote"
      put "dislike", to: "recipes#downvote"
    end
  end

  get "/my_recipes", to: "recipes#my_recipes"

  root to: "recipes#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
