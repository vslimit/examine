module Manage
  class AdminsController < Manage::ApplicationController

    layout 'fancybox' ,:only => [:pwd,:reset_password]
    def index
      page_info = get_paging_order_info
      @search = Admin.search(params[:q])
      @admins = @search.result(:distinct => true).paginate(page: page_info[:page], per_page: page_info[:limit])
    end

    def new
      @admin = Admin.new
    end

    def edit
      @admin = Admin.find(params[:id])
    end

    def create
      @admin = Admin.new
      @admin.login = params[:login]
      @admin.name = params[:name]
      @admin.role = params[:role]
      @admin.password = params[:password]

      begin
        if @admin.save!
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

    def update
      @admin = Admin.find(params[:id])
      @admin.name = params[:name]
      @admin.login = params[:login]
      @admin.role = params[:role]
      @admin.password = params[:password] if not params[:password].blank?
      begin
        if @admin.save!
          flash[:success] = Tips::UPDATE_SUCCESS
          redirect_to action: :index
        else
          flash[:error] = Tips::UPDATE_ERROR
          redirect_to action: :edit
        end
      rescue StandardError => e
        flash[:error] = e.message
        redirect_to action: :edit
      end
    end

    def destroy
      @admin = Admin.find(params[:id])
      if @admin.destroy
        flash[:success] = Tips::DELETE_SUCCESS
      else
        flash[:error] = Tips::DELETE_ERROR
      end
      redirect_to :root
    end

    def pwd
      @admin = Admin.new
      render 'manage/admins/reset_password'
    end

    def reset_password
      admin = current_manage_user
      if not admin.authenticate(params[:old_password])
        flash[:error] = Tips::PASSWORD_ERROR
      else
        admin.password = params[:password]
        admin.save!
        flash[:success] = Tips::UPDATE_SUCCESS
      end
    end
  end
end
