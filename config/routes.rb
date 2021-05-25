# frozen_string_literal: true

Rails.application.routes.draw do
  root 'diaries#index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/diaries/:user_id/:date_id', to: 'diaries#show', as: :show_diary
  get '/:uuid/:date_id', to: 'diaries#show_with_token', as: :show_with_token
  put '/diaries', to: 'diaries#update', as: :update_diary
  post '/diaries', to: 'diaries#create', as: :create_diary
  # anything not matched by the above should be served the index page
  get '/*path' => 'diaries#index'
end
