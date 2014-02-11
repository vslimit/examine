class ApplicationController < ActionController::Base
  include SessionManager
  #protect_from_forgery
  before_filter :check_login, :check_profile
  #rescue_from CanCan::AccessDenied do |exception|
  #  flash[:error] = Tips::ACCESS_ERROR
  #  redirect_to '/manage/subjects'
  #end

  def get_paging_order_info
    {
        :page => params[:page],
        :limit => params[:limit].nil? ? 20 : params[:limit]
    }
  end

  def check_login
    unless logged_in?
      flash[:error] = 'Please login in first'
      redirect_to '/login'
    end
  end

  def check_profile
    @profiles = Profile.all
    @subject_type_hash = {}
    @subject_profile_hash = {}
    @score_profile_hash = {}
    @examine_profile_hash = {}
    #profile_hash = {}
    @profiles.select{ |x| x.dic_type == Profile::SUBJECT_TYPE }.each do |profile|
      @subject_type_hash[profile.dic_key] = profile.dic_value
    end
    @profiles.select{ |x| x.dic_type == Profile::SUBJECT_PROFILE }.each do |profile|
      @subject_profile_hash[profile.dic_key] = profile.dic_value
    end
    @profiles.select{ |x| x.dic_type == Profile::SCORE_PROFILE }.each do |profile|
      @score_profile_hash[profile.dic_key] = profile.dic_value
    end
    @profiles.select{ |x| x.dic_type == Profile::EXAMINE_PROFILE }.each do |profile|
      @examine_profile_hash[profile.dic_key] = profile.dic_value
    end

  end

end
