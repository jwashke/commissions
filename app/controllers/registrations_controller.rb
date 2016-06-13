class RegistrationsController < Devise::RegistrationsController
  protected

  def after_sign_up_path_for(resource)
    signing_path
  end
end
