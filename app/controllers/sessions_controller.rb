#encoding:utf-8
class SessionsController < ApplicationController
  skip_authorize_resource
  skip_before_filter :check_login
  layout :false

  def new

  end

  def create
    #destroy_session
    if (Date.parse(@examine_profile_hash['examine_date']) - Date.parse(Time.now.strftime('%Y-%-m-%-d'))).to_i > 0
      flash[:error] = Tips::LOGIN_NO_START
      redirect_to '/login'
      return
    end

    card_no = params[:login]
    password = params[:password]
    user = User.where({:card_no => card_no}).first

    if user.on_line == User::ON && !user.session_id.blank?
      flash[:error] = Tips::LOGIN_AGAIN
      redirect_to '/login'
      return
    end

    if user && password == @examine_profile_hash['password']
      create_session user
      user.session_id = session['session_id']
      user.on_line = User::ON
      user.save!
      redirect_to (Date.parse(@examine_profile_hash['examine_date']) - Date.parse(Date.parse(user.scores.last.exam_date).strftime('%Y-%-m-%-d'))).to_i <= 0 ? '/score' : '/examines'
      return
    else
      flash[:error] = Tips::LOGIN_ERROR
      redirect_to '/login'
      return
    end

  end

  def logout
    destroy_session
    redirect_to '/login'
  end
end

