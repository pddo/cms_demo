# typed: true
class AdminSessionsController < CmsMainController
  before_action :require_no_admin, :only => [:new, :create]
  before_action :require_admin, :only => :destroy

  layout "cms"

  def new
    @admin_session = AdminSession.new
  end

  def create
    @admin_session = AdminSession.new(session_params.to_h)
    if @admin_session.save
      flash[:notice] = I18n.t('authen.login_msg')
      redirect_to rails_admin.dashboard_path
    else
      render :action => :new
    end
  end

  def destroy
    current_admin_session.destroy
    flash[:notice] = I18n.t('authen.logout_msg')
    redirect_to main_app.login_path
  end

  protected

  def session_params
    params.require(:admin_session).permit(:login, :password, :remember_me)
  end
end
