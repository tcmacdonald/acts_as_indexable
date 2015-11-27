Rails.application.routes.draw do
  resources :widgets do
    get :export, on: :collection
  end
  root 'widgets#index'
end
