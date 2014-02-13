#encoding:utf-8
module Manage
  class ProfilesController < Manage::ApplicationController
    def index
      page_info = get_paging_order_info
      @search = Profile.search(params[:q])
      @profiles = @search.result(:distinct => true).paginate(page: page_info[:page], per_page: page_info[:limit])
    end

    def new
      @profile = Profile.new
    end

    def create
      @profile = Profile.new
      @profile.dic_key = params[:dic_key]
      @profile.dic_value = params[:dic_value]
      @profile.dic_type = params[:dic_type]
      @profile.dic_type_name = Profile::TYPE_MAP[params[:dic_type]]

      begin
        if @profile.save!
          flash[:success] = Tips::CREATE_SUCCESS
          redirect_to action: :index
        else
          flash[:error] = Tips::CREATE_ERROR
          redirect_to action: :new
        end
      rescue StandardError => e
        flash[:error] = e.message
        redirect_to action: :new
      end
    end

    def edit
      @profile = Profile.find(params[:id])
      render :layout => 'fancybox'
    end

    def update
      begin
        @profile = Profile.find(params[:id])
        @profile.dic_key = params[:dic_key]
        @profile.dic_value = params[:dic_value]
        @profile.dic_type = params[:dic_type]
        #@profile.dic_type_name = params[:dic_type_name]
        @profile.save!
      rescue StandardError => e
        flash[:error] = e.message
        render :action => 'edit', :layout => 'fancybox'
        return false
      end
      render inline: "<script type='text/javascript'>parent.window.location.reload();</script>"
    end

    def destroy
      #if Category.has_child(params[:id])
      #  flash[:error] = Tips::DELETE_ERROR << ',该类型下有子类,请先删除子类'
      #else
      @profile= Profile.destroy(params[:id])
      flash[:success] = Tips::DELETE_SUCCESS
      #end
      redirect_to '/manage/profiles'
    end
  end
end