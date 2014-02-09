module Manage
  class SubjectsController < Manage::ApplicationController
    def index
      page_info = get_paging_order_info
      @search = Subject.search(params[:q])
      @subjects = @search.result(:distinct => true).paginate(page: page_info[:page], per_page: page_info[:limit])
    end

    def new
      @type = 'new'
      @subject = Subject.new
      @answer = Answer.new
    end

    def create
      subject_type = params[:subject_type]
      begin
        Subject.create_subject!(params[:title], params[:air], subject_type == 'true-false' ? params[:answer] : params[:sign], params[:category_id], subject_type, params[:sign], params[:content])
        flash[:success] = Tips::CREATE_SUCCESS
        redirect_to action: :index
      rescue StandardError => e
        flash[:error] = e.message

        redirect_to action: :new
      end
    end

    def show
      @subject = Subject.find(params[:id])
    end

    def edit
      @type = 'edit'
      @subject = Subject.find(params[:id])
    end

    def update
      subject_type = params[:subject_type]
      begin
        Subject.update_subject!(params[:id],params[:title], params[:air], subject_type == 'true-false' ? params[:answer] : params[:sign], params[:category_id], subject_type, params[:sign], params[:content])
        flash[:success] = Tips::UPDATE_SUCCESS
        redirect_to action: :index
      rescue StandardError => e
        flash[:error] = e.message
        redirect_to action: :edit
      end
    end

    def destroy
      @subject = Subject.destroy(params[:id])
      redirect_to action: :index
    end
  end
end

