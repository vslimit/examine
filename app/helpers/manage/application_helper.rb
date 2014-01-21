#encoding:utf-8
module Manage
  module ApplicationHelper
    def display_user
      "#{role_text(session[:login_admin][:role])}：#{session[:login_admin][:login]}"
    end
  end
end