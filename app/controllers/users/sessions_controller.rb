class Users::SessionsController < Devise::SessionsController
    def create
      super do |user|
        if user.verification_code.present? && params[:verification_code] == user.verification_code
          # Verification code is correct, continue with sign-in
        else
          flash[:alert] = 'Invalid verification code.'
          redirect_to new_user_session_path
        end
      end
    end
  end
  