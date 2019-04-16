require 'csv'
require 'twilio_rest'
class AdminController < ApplicationController
  include TwilioRest

  def summary
    @user= current_user
  end

  def logs
    listing_whatsapp_message
    @events= Event.all
    respond_to do |format|
      format.html{ @events}
      format.js
      format.csv { send_data to_csv(@events), filename: "events-#{Date.today}.csv" }
    end
  end

  def admin_settings
    @users =User.where(role_id:2, account_activated:true)
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
private
  def to_csv(events)
    attributes = %w{created_at, user, phone_number, category, message }
    CSV.generate(headers: true) do |csv|
      csv << attributes
       events.each do |event|
        csv <<[event.created_at, "event.user.email", "event.user.phone_number", event.category.name, event.message]
       end
    end
  end
end
