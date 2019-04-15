class ApplicationController < ActionController::Base
  respond_to :html, :json
  protect_from_forgery with: :exception
  # before_filter :check_phone_verify,except: [:verify_token,:resend_activation_token,:session_reset,:create]
  # before_filter :online_users
# def after_sign_in_path_for(resource)
# home_profile_path
# end

# rescue_from CanCan::AccessDenied do |exception|
#     # render "/home/cancan.html.erb"
#     # puts "exception",exception
#      # flash[:error] = "Access denied!"
#   # redirect_to :back
#     redirect_to main_app.root_url, :alert => exception.message
#   end

#Overriding devise method after_sign_in_path_for
# After sign_in_path_for helper from devise to define the url after
# sign_in, if the user has complete its phone_verification and other
# profile details he will be redirected to dashboard
# before_filter { |c| current_user.track unless current_user.nil?}
# def online_users
#     @users=User.online(60)
#     @online_users=[]
#     if user_signed_in?
#     if @users.present?
#     @users.each do |u|
#      if u.id != current_user.id
#        @online_users << u
#      end
#     end
#   end
# end
# end
 # def authenticate_user!(return_point = request.url)
 #    unless user_signed_in?
 #      set_return_point(return_point)
 #      redirect_to root_path
 #    end
 #  end

 #  def return_point
 #    session[:return_point] || root_path
 #  end


  protected
  def authenticate_user!
    if user_signed_in?
      super
    else
      redirect_to root_path, :notice => 'if you want to add a notice'
      ## if you want render 404 page
      ## render :file => File.join(Rails.root, 'public/404'), :formats => [:html], :status => 404, :layout => false
    end
  end
def check_phone_verify
 if user_signed_in?
    if current_user.phone_verified != true && action_name !="index"
      respond_to do |format|
      format.html {
       redirect_to root_path
      }
      end
    end
  end
end

def after_sign_in_path_for(resource)
    # if resource.is?(:doctor) && resource.is_approved== false
    #   redirect_to root_path
    # else
      # if resource.phone_verified? && !resource.is?(:admin)
      #   dashboard_path
      # else
        root_path
      # end
    # end
  end
# Overriding devise method  after_sign_out_path_for
#After sign_out path directs the user to this particular url on sign out
  # def after_sign_out_path_for(resource_or_scope)
  #    params[:back].nil? ? root_path : params[:back]
  # end


  # def after_sign_up_path_for(resource)
  #   root_path
  # end
end
