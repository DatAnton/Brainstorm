Rails.application.routes.draw do
  root to: "challenge#new"
  resources :challenge, only: [:new, :create, :show] do
    get '/matrix', to: 'challenge#matrix'
    get '/result', to: 'challenge#result'
    resources :answer, only: [:create, :update, :index] do
      get '/sort', to: 'answer#sort'
    end
  end
end
