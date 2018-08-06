class CmsMainController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_admin_session, :current_admin

  rescue_from CanCan::AccessDenied do
    redirect_back_or_default(rails_admin.dashboard_path)
  end

  protected

  def current_ability
    @current_ability ||= Ability.new(current_admin)
  end

  def current_admin_session
    return @current_admin_session if defined?(@current_admin_session)
    @current_admin_session = AdminSession.find
  end

  def current_admin
    return @current_admin if defined?(@current_admin)
    @current_admin = current_admin_session && current_admin_session.admin
  end

  def require_admin
    unless current_admin
      store_location
      flash[:notice] = "Your session has expired. Please log in again."
      redirect_to main_app.login_path
    end
  end

  def require_no_admin
    if current_admin
      store_location
      flash[:notice] = "You must be logged out to access this page"
      redirect_to main_app.logout_path
    end
  end

  def store_location
    session[:return_to] = request.original_url
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end
