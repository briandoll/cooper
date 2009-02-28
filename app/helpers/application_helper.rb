# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include AuthenticatedSystem
  
  def current_user_is_admin?
    (logged_in? && current_user.admin? )
  end
end
