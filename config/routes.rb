Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :answers
  resources :choices
  resources :questions
  resources :chapters
  resources :topics
  resources :subjects
  resources :exams do
    get :get_details, :on => :collection
  end
  root to: 'exams#index'
  devise_for :users, :controllers => {:sessions => 'sessions',:registrations => 'registrations'}
end
