# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  include AuthenticatedSystem
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '6b4eec1d67d3e8ac739030cde388e5f1'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  # used as a filter in controllers
  def ensure_logged_in
    if (!logged_in?)
      redirect_to login_url
    end
  end
  
  def ensure_current_user_is_admin
    if (!logged_in? || !current_user.admin? )
      flash[:failure] = "You must be an administrator to access that page."
      redirect_to root_url
    end
  end
  
end
