# frozen_string_literal: true

Rails.application.routes.draw do
  root 'welcome#index'
  get '/auth/:provider/callback' => 'sessions#create'
  get 'status' => 'status#index', defaults: { format: 'json' }
  delete '/logout' => 'sessions#destroy'

  resources :retirements, only: %i[new create]

  resources :events, only: %i[new create show edit update destroy] do
    resources :tickets, only: %i[new create destroy]
  end

  match '*path' => 'application#error404', via: :all
end
