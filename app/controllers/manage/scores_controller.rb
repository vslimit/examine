module Manage
  class ScoresController < Manage::ApplicationController
    layout :false, :only => [:show]

    def index
      page_info = get_paging_order_info
      @search = Score.search(params[:q])
      @scores = @search.result(:distinct => true).paginate(page: page_info[:page], per_page: page_info[:limit])
    end

    def destroy
      @score = Score.find(params[:id])
      if @score.destroy
        flash[:success] = Tips::DELETE_SUCCESS
      else
        flash[:error] = Tips::DELETE_ERROR
      end
      redirect_to action: :index
    end

    def show
      @score = Score.find(params[:id])
    end
  end
end
