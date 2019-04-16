require 'twilio_rest'

class WorkerController < ApplicationController
  include TwilioRest

  def settings
    #send_message(current_user.phone_number, params[:otp])
  end


    def phone_verification


    end

    def check_otp
      @otp= params[:otp]
      # send_message(current_user.phone_number, params[:otp])
            respond_to do |format|
               format.js
             end
    end

    def check_verification
      respond_to do |format|
      user=  User.find_by_phone_number(params[:user][:phone])
      if(User.find_by_phone_number(params[:user][:phone]).present?)
        if user.activation_token == params[:user][:otp]
           user.phone_verified =true
           if(user.confirmed? ==true)
             user.account_activated =true
          end
             user.save
        end
      notice = "User account activated"
      else
       notice = "User not found"
      end
      format.js{ redirect_to phone_verification_path, flash: {notice: notice} }
    end
    end


  def change_password
    @message = "Passwords do not match."
    if params[:new_password].present? && params[:confirm_password].present? && (params[:new_password] == params[:confirm_password])
      @user = current_user
      if @user.valid_password?(params[:old_password])
        if @user.update_attribute(:password,params[:new_password])
          @message = "Password updated!"
          @success=true
          reset_session
          redirect_to root_path
        else
          @message = "Password not updated"
        end
      else
        @message = "Incorrect old password"
      end
     else
       @message="Password and Confirm Password does not match"
    end
    puts "pass", @message
  end
#Updating email for the current user and sending a
#confirmation mail on user's account
  def change_email
    if params[:email].present?
      current_user.update_attributes(:email=>params[:email],:uid=>"",:provider=>"")
      @message = "Confirmation Mail has been sent ,please confirm to update your email"
    else
      @message ="Email is blank or invalid"
   end
  end


end
