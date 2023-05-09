class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def google_oauth2
      @user = User.from_omniauth(request.env['omniauth.auth'])
  
      if @user.persisted? && @user.email.end_with?('@ceu.edu.ph')
        sign_in_and_redirect @user, event: :authentication
        set_flash_message(:notice, :success, kind: 'Google') if is_navigational_format?
      else
        flash[:alert] = 'Only users with an @ceu.edu.ph email address are allowed to register.'
        redirect_to new_user_registration_url
      end
    end
  end
  