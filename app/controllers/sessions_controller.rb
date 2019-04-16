class SessionsController < Devise::SessionsController
  #       skip_before_filter :verify_authenticity_token, if: :json_request?
  respond_to :json,:js,:html
  before_action :check_worker_approved,:only => :create
  before_action :handle_failed_login, :only => :new
def new
  super
end
  def create
     respond_to do |format|

         # if @reset_session != true
         #  if  @user_not_found !=true
         if( @account_activated==true)
           resource = warden.authenticate!(:scope => resource_name, :recall => "sessions#handle_failed_login")
           @user=resource
           sign_in(resource_name, resource)  # this will set cookie
                  format.html {redirect_to  root_path}

         elsif @email_not_verified ==true
              format.html { redirect_to new_user_confirmation_path, flash: {notice: "Email is not verified"}}
         elsif @phone_not_verified==true
             format.html {  redirect_to phone_verification_path,flash: {notice: "Phone has not beeen verified"}}
         else
            format.html {redirect_to root_path,flash: {notice: "User not found"}}
          end


         # elsif @user_not_confirmed ==true
         #  @message ="Email has not been Confirmed"
         # else
         #   @message= "Invalid Login Credentials"
         # end
         # else
         #    reset_session
         #    @message= "Admin need to activate your account"
         # end

     # if resource.is?(:doctor) && resource.is_approved == false
     #  reset_session
     #  $message= "Admin need to activate your account"
     #  # session.clear
     # end
      # format.html
      format.js
    end
  end

  def handle_failed_login

  end


    def check_worker_approved
    @user= User.find_by_email(params[:user][:email])
    if !@user.nil?
       if @user.is?(:worker)  && (@user.account_activated ==false || @user.account_activated ==nil)
         if @user.confirmed? ==false
           @email_not_verified =true
         else
           @phone_not_verified= true
         end
        else
         @account_activated=true

       end
    else
      @user_not_found=true
    end
  end
end
