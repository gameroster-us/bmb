Rails.application.routes.draw do
  get 'registrations/send_verification_code'
  root 'home#index'

  devise_for :users, controllers: {
  registrations: 'users/registrations',
  sessions: 'users/sessions'
}

  resources :organizations do
    resources :grounds, only: [:new, :create] do
      resources :gslots do
        member do
          post 'payment', to: 'gslots#payment', as: 'payment'
        end
      end
    end
  end
  get '/payments/success', to: 'payments#success', as: 'payment_success'

  post '/organizations/:organization_id/grounds/:ground_id/payment', to: 'gslots#payment', as: 'payment'
 
  resources :grounds do
    resources :gslots
  end
  post 'payment', to: 'gslots#payment', as: 'payment_data' 
  # post 'payment', to: 'gslots#data', as: 'payment_data'

  authenticate :user do
    resources :payments 
  end
  
  authenticate :user do
    resources :gslots, only: [:payment]
  end

  get "/verify_otp", to: "users/registrations#verify_otp", as: :verify_otp

 
  get '/ground_gslots/check_slots', to: 'gslots#check_slots'
  get '/get_date', to: 'gslots#get_date'
end
