#encoding:utf-8
module Manage
  class CategoriesController < Manage::ApplicationController

    #layout 'fancybox' ,:only => [:edit]

    def index
      page_info = get_paging_order_info
      @search = Category.search(params[:q])
      @categories = @search.result(:distinct => true).paginate(page: page_info[:page], per_page: page_info[:limit])
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new
      @category.name = params[:name]
      pid = params[:pid]
      @category.pid = pid
      code = params[:code]
      if !pid.blank? && pid.to_i > 0
        category = Category.find(params[:pid])
        code = category.code << '<<' <<params[:code]
      end
      @category.code = code
      @category.level_value
      begin
        if @category.save!
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
      @category = Category.find(params[:id])
      render :layout => 'fancybox'
    end

    def update
      begin
        @category = Category.find(params[:id])
        @category.name = params[:name]
        pid = params[:pid]
        @category.pid = pid
        code = params[:code]
        if !pid.blank? && pid.to_i > 0
          category = Category.find(params[:pid])
          code = category.code << '<<' <<params[:code]
        end
        @category.code = code
        @category.level_value
        @category.save!
      rescue StandardError => e
        flash[:error] = e.message
        render :action => 'edit', :layout => 'fancybox'
        return false
      end
      render inline: "<script type='text/javascript'>parent.window.location.reload();</script>"
    end

    def destroy
      if Category.has_child(params[:id])
        flash[:error] = Tips::DELETE_ERROR << ',该类型下有子类,请先删除子类'
      else
        @category= Category.destroy(params[:id])
        flash[:success] = Tips::DELETE_SUCCESS
      end
      redirect_to action: :index
    end
  end
end