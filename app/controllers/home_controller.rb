require 'csv'

class HomeController < ApplicationController
   def summary
    binding.pry
    @user= current_user

   end

   def logs
      @events= Event.all
      respond_to do |format|
        format.html{ @events}
        format.js
        format.csv { send_data to_csv(@events), filename: "events-#{Date.today}.csv" }
       end
   end


   def settings

   end

   def admin_settings
     @users =User.where(role_id:2, account_activated:true)
    end

   def index
   end

   def promote_worker
     respond_to do |format|
       user= User.find(params[:id])
       user.update_attributes(role_id:1)
     end
   end

   def delete_worker
       if !Poll.where(user_id: params[:id], admin_id: current_user.id).present?
        poll = Poll.create(user_id: prams[:id], admin_id:current_user.id, status:false)
      end
       number_of_admin_support=Poll.where(user_id: params[:user_id]).count
       total_admin =User.where(role_id:1).count
       three_fourth_admin= ((3.0/4.0)*total_admin.to_f).round
       if number_of_admin_support >=three_fourth_admin
         User.where(id: params[:user_id]).update_attributes(account_activated:false)
         @success =true
       else
         @success =false
       end
   end

    def phone_verification


    end
    def check_verification
  respond_to do |format|

      user=  User.find_by_phone_number(params[:user][:phone])
      if( User.find_by_phone_number(params[:user][:phone]).present?)
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
        else
          @message = "Password not updated"
        end
      else
        @message = "Incorrect old password"
      end
     else
       @message="Password and Confirm Password does not match"
    end

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

   def to_csv(logs)
    attributes = %w{data}

    CSV.generate(headers: true) do |csv|
      csv << attributes

        csv <<[logs]
    end
  end
 end
