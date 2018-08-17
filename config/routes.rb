Rails.application.routes.draw do
  root to: "challenge#new"
  resources :challenge, only: [:new, :create, :show] do
    get '/extra', to: 'challenge#extra'
    get '/report', to: 'challenge#report'
    get '/matrix', to: 'challenge#matrix'
    get '/result', to: 'challenge#result'
    get '/prepare', to: 'challenge#prepare'
    post '/report', to: 'challenge#send_report'
    resources :answer, only: [:create, :update, :index] do
      post '/swap/:right_id', to: 'answer#swap', as: :swap
      get '/compare/:right_id', to: 'answer#compare', as: :compare
    end
  end
end
