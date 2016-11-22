Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :slack do
      post '/message', to: 'slack#message', as: :message
      post '/group-joined', to: 'slack#group_joined', as: :group_joined
    end
  end
end
