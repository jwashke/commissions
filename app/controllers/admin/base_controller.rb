class Admin::BaseController < ApplicationController
  before_action :require_admin

  def require_admin
    render file: "/public/404", status: :not_found unless current_user && current_admin?
  end
end
