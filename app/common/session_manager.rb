module SessionManager

  #def create_session(user)
  #  #session[:admin_id] = user.id
  #  session[:login_admin] = {
  #      :id => user.id,
  #      :username => user.name,
  #      :real_name => user.real_name,
  #      :role_name => user.role_name
  #  }
  #end
  #
  #def destroy_session
  #  session.clear
  #end
  #
  #def current_user
  #  @current_user ||= session[:login_admin] && (Admin.find(session[:login_admin][:id]))
  #end
  #
  #def logged_in?
  #  !session[:login_admin].nil?
  #end

  def create_manage_session(admin)
    session[:login_admin] = {
        :id => admin.id,
        :name => admin.name,
        :login => admin.login,
        :role => admin.role,
    }
  end

  def destroy_manage_session
    #session.clear
    session[:login_admin] = nil
  end

  def current_manage_user
    @current_manage_user ||= session[:login_admin] && (Admin.find(session[:login_admin][:id]))
  end

  def manage_logged_in?
    !session[:login_admin].nil?
  end
end