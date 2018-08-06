class AdminSessionsController < CmsMainController
  before_action :require_no_admin, :only => [:new, :create]
  before_action :require_admin, :only => :destroy

  layout "cms"

  LOGOUT_MSG = "Log out successful!"
  
  def new
    @admin_session = AdminSession.new
  end
  
  def create
    @admin_session = AdminSession.new(params[:admin_session])
    if @admin_session.save
      flash[:notice] = "Log in successful!"
      redirect_to rails_admin.dashboard_path
    else
      render :action => :new
    end
  end
  
  def destroy
    current_admin_session.destroy
    flash[:notice] = "Log out successful!"
    redirect_to main_app.login_path
  end
end
