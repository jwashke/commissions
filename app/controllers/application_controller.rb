class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_admin?

  def require_user_and_user_signed_docs
    redirect_to root_path unless user_signed_in? && current_user.signed_docs?
  end

  def current_admin?
    current_user && current_user.admin?
  end
end
