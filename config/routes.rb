Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
   devise_for :users, :controllers => { :registrations => 'registrations' ,:sessions => 'sessions',confirmations: 'confirmations',:passwords => "passwords"}
    get 'summary'=>'home#summary'
    get 'logs' => "home#logs"
    get 'home/settings'=> 'home#settings'
    get 'change_password'=> 'home#change_password'
    get 'change_email'=> 'home#change_email'
    get 'phone_verification'=>'home#phone_verification'
    get 'check_verification'=>'home#check_verification'
    get 'admin_settings' =>'home#admin_settings'
    get '/promote_worker/:id', to: 'home#promote_worker',as: 'promote_worker'
    get '/delete_worker/:id', to: 'home#delete_worker',as: 'delete_worker'
    get 'check_otp'=> 'home#check_otp'
    root 'home#index'
end
