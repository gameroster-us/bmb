class ApplicationController < ActionController::Base
  include Pundit

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :authenticate_user!

  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index
  
  after_action :verify_authorized, unless: :devise_controller?

private

def devise_controller?
  is_a?(Devise::SessionsController) ||
    is_a?(Devise::RegistrationsController) ||
    is_a?(Devise::PasswordsController)
end

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end
  
  before_action :authenticate_user!
  protect_from_forgery with: :null_session
    def after_sign_in_path_for(resource)
        organizations_path
      end
end
