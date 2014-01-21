#encoding:utf-8
class SessionsController < ApplicationController
  skip_authorize_resource
  skip_before_filter :check_login
  layout :false

  def new

  end

  def create
    destroy_session
    username = params[:username]
    password = params[:password]
    #system_user = CoreLib::SystemUser.where({:name => username}).first
    #if system_user and system_user.authenticate(password)
    #  create_session system_user
    #record_activities('登录','登录',"[#{params[:username]}]登录系统")
    redirect_to '/merchant/merchant_stores'
    #else
    #  flash[:error] = Tips::LOGIN_ERROR
    #  redirect_to :root
    #end
  end

  def logout
    destroy_session
    redirect_to :root
  end
end
