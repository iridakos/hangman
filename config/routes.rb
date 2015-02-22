Rails.application.routes.draw do
  root :to => 'home#index'

  resource :game, :only => [:new, :show, :update, :destroy]
end
