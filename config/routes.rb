Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   devise_for :users, :controllers => { :registrations => 'registrations' ,:sessions => 'sessions',confirmations: 'confirmations',:passwords => "passwords"}
    get 'summary'=>'admin#summary'
    get 'logs' => "admin#logs"
    get 'worker/settings'=> 'worker#settings'
    get 'change_password'=> 'worker#change_password'
    get 'change_email'=> 'worker#change_email'
    get 'phone_verification'=>'worker#phone_verification'
    get 'check_verification'=>'worker#check_verification'
    get 'admin_settings' =>'admin#admin_settings'
    get '/promote_worker/:id', to: 'admin#promote_worker',as: 'promote_worker'
    get '/delete_worker/:id', to: 'admin#delete_worker',as: 'delete_worker'
    get 'check_otp'=> 'worker#check_otp'
    root 'home#index'
end
