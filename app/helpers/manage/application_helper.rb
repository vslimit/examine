#encoding:utf-8
module Manage
  module ApplicationHelper
    def display_user
      "#{role_text(session[:login_admin][:role])}：#{session[:login_admin][:login]}"
    end

    def date_text(date)
      date.strftime('%Y-%-m-%-d') unless date.nil?
    end
  end
end