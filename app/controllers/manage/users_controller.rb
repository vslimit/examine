module Manage
  class UsersController < ApplicationController

    #layout 'fancybox' ,:only => [:pwd,:reset_password]
    def index
      page_info = get_paging_order_info
      @search = User.search(params[:q])
      @users = @search.result(:distinct => true).paginate(page: page_info[:page], per_page: page_info[:limit])
    end

    def new
      @user = User.new
    end

    def edit
      @user = User.find(params[:id])
    end

    def create
      @user = User.new
      @user.login = params[:login]
      @user.name = params[:name]
      @user.role = params[:role]
      @user.password = params[:password]

      begin
        if @user.save!
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
      @user = User.find(params[:id])
      @user.name = params[:name]
      @user.login = params[:login]
      @user.role = params[:role]
      @user.password = params[:password] if not params[:password].blank?
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
      @user = User.find(params[:id])
      if @user.destroy
        flash[:success] = Tips::DELETE_SUCCESS
      else
        flash[:error] = Tips::DELETE_ERROR
      end
      redirect_to :root
    end

  end
end
