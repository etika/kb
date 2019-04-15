#Overriden Registration  Controller of devise
require 'twilio_rest'

class RegistrationsController < Devise::RegistrationsController
    include TwilioRest

  def new
    @user = User.new
  end
#overriding create action of devise
  def create
    @errors_message=""
    number_to_send_to = "+91#{params[:user][:phone_number]}"
    respond_to do |format|
      @user = User.new(permitted_user)
      if @user.save
        puts "Data Saved Successfully"
         begin
           if params[:user][:activation_token].present?
             send_message(number_to_send_to,params[:user][:activation_token])
             @user.update_attributes(:phone_verified=>false)
           end
         rescue Exception => e
           puts "caught exception #{e}! ohnoes!"
         end
          format.js { render :file => "/devise/registrations/create.js.erb" }
          format.html{ redirect_to root_path}
      else
        @errors=@user.errors
        if  @errors.present?
          @errors.full_messages.each do |err|
            @errors_message+=err+ "<br>"
        end
        @errors_message=@errors_message.html_safe
        format.js { render :file => "/devise/registrations/create.js.erb" }
        format.html {render "/devise/registrations/new.html.erb"}
      end

      @errors_message=@errors_message.html_safe
    end
  end

protected
def permitted_user
  params.require(:user).permit(:email,:role_id,:uid,:password,:activation_token,:password_confirmation,:phone_number)
end
end
