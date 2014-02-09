#encoding:utf-8
class SessionsController < ApplicationController
  skip_authorize_resource
  skip_before_filter :check_login
  layout :false

  def new

  end

  def create
    destroy_session
  end

  def notice

  end

  def logout
    destroy_session
    redirect_to :root
  end

  def create
    destroy_session
    card_no = params[:login]
    #password = params[:password]
    user = User.where({:card_no => card_no}).first
    if user
      create_session user
      redirect_to '/examines'
    else
      flash[:error] = Tips::LOGIN_ERROR
      redirect_to '/login'
    end
  end

  def logout
    destroy_manage_session
    redirect_to '/login'
  end
end
