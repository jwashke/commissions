module NavbarHelper
  def link_to_sign_in_or_sign_out
    if current_user
      link_to "Sign Out", destroy_user_session_path, method: :delete
    else
      link_to "Sign in", new_user_session_path
    end
  end
end
