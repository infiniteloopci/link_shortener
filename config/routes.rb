Rails.application.routes.draw do
  resources :links, only: [:new, :create, :show]
  get '/:token' => 'links#forward', as: :forward_link
  root to: 'links#new'
end
