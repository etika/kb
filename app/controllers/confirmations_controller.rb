class ConfirmationsController < Devise::ConfirmationsController
  private

  def after_confirmation_path_for(resource_name, resource)
   root_path(:notice=> "Email has been confirmed")
  end

end
