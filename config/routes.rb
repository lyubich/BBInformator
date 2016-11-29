Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :slack do
      post '/message', to: 'slack#message', as: :message
      post '/group-joined', to: 'slack#group_joined', as: :group_joined
      post '/user-change', to: 'slack#user_change', as: :user_change
      post '/team-join', to: 'slack#team_join', as: :team_join
    end
  end
end
