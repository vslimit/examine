#encoding:utf-8
class NoticesController < ApplicationController
  skip_authorize_resource
  skip_before_filter :check_login

  layout 'fancybox'

  def show

  end


end
