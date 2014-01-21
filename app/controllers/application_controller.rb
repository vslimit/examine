class ApplicationController < ActionController::Base
  include SessionManager
  protect_from_forgery
  before_filter :check_login
  rescue_from CanCan::AccessDenied do |exception|
    flash[:error] = Tips::ACCESS_ERROR
    redirect_to '/manage/subjects'
  end

  def get_paging_order_info
    {
        :page => params[:page],
        :limit => params[:limit].nil? ? 20 : params[:limit]
    }
  end

  def check_login
    unless manage_logged_in?
      flash[:error] = 'Please login in first'
      redirect_to '/manage/login'
    end
  end

end
