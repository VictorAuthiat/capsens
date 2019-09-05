def authenticate_admin!
  redirect_to new_user_session_path unless current_user && current_user.admin
end
ActiveAdmin.setup do |config|
  config.authentication_method = :authenticate_admin!
  config.current_user_method = :current_user
  config.logout_link_path = :destroy_user_session_path
  config.logout_link_method = :delete
end
