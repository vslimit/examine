module SessionManager

  def create_session(user)
    session[:user] = {
        :id => user.id,
        :username => user.name,
        :card_no => user.card_no
    }
  end

  def destroy_session
    session.clear
  end

  def current_user
    @current_user ||= session[:user] && (User.find(session[:user][:id]))
  end

  def logged_in?
    !session[:user].nil?
  end

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