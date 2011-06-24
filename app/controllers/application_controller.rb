class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  
  before_filter do |controller, action| 
    require_login if params[:controller] != "session"
  end
  
    
  
  private
  def current_user
    @current_user ||= Usuario.find(session[:usuario_id]) if session[:usuario_id]  
  end
  
  def require_login
    redirect_to '/session/login' if !current_user
  end
  
end
