#encoding:utf-8
class SessionsController < ApplicationController
  skip_authorize_resource
  skip_before_filter :check_login
  layout :false

  def new

  end

  def create
    #destroy_session
    card_no = params[:login]
    password = params[:password]
    user = User.where({:card_no => card_no}).first
    if user.on_line == User::ON && !user.session_id.blank?
      flash[:error] = Tips::LOGIN_AGAIN
      redirect_to '/login'
    elsif user && password == @examine_profile_hash['password']
      create_session user
      user.session_id = session['session_id']
      user.on_line = User::ON
      user.save!
      redirect_to '/examines'
    else
      flash[:error] = Tips::LOGIN_ERROR
      redirect_to '/login'
    end
  end

  def logout
    destroy_session
    redirect_to '/login'
  end
end
