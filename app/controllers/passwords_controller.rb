class PasswordsController <  Devise::PasswordsController
   def create

    self.resource = resource_class.send_reset_password_instructions(resource_params)

            if successfully_sent?(resource)
            flash[:notice] = "sent password"
            else
              respond_with(resource)
            end
        end
end
