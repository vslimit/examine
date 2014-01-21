module Manage
  class SubjectsController < Manage::ApplicationController
    def index
      page_info = get_paging_order_info
      @search = Subject.search(params[:q])
      @subjects = @search.result(:distinct => true).paginate(page: page_info[:page], per_page: page_info[:limit])
    end

    def new
      @subject = Subject.new
      @answer = Answer.new
    end

    def create
      @subject = Subject.new title: params[:title]
      @subject.answer = params[:answer]
      @subject.air = params[:air]
      @subject.category_id = params[:category_id]
      @subject.subject_type = params[:subject_type]
      @subject.code = Category.find(params[:category_id]).code << '::' << params[:subject_type]
      begin
        if @subject.save!
          signs = params[:sign]
          contents = params[:content]
          if !signs.blank? && signs.length > 0
            signs.each_index { |i|
              @answer = Answer.new
              @answer.content = contents[i]
              @answer.sign = signs[i]
              @answer.subject_id = @subject.id
              @answer.save!
            }
          end
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

    def show
      @subject = Subject.find(params[:id])
    end

    def edit
      @subject = Subject.find(params[:id])
    end

    def update
      @subject = Subject.find(params[:id])
      subject_type = @subject.subject_type
      param_subject_type = params[:subject_type]
      @subject.title = params[:title]
      @subject.air = params[:air]
      @subject.category_id = params[:category_id]
      @subject.subject_type = params[:subject_type]
      @subject.code = Category.find(params[:category_id]).code << '::' << params[:subject_type]
      begin
        if @subject.save!
          if subject_type == 'true-false' && param_subject_type != 'true-false'
            signs = params[:sign]
            contents = params[:content]
            signs.each_index { |i|
              @answer = Answer.new
              @answer.content = contents[i]
              @answer.sign = signs[i]
              @answer.subject_id = @subject.id
              @answer.save!
            }
          elsif subject_type !='true-false' && param_subject_type =='true-false'
            Answer.delete_all(['subject_id = ?', @subject.id])
          elsif subject_type !='true-false' && param_subject_type != 'true-false'
            signs = params[:sign]
            contents = params[:content]
            ids = params[:ids]
            ids.each_index { |i|
              @answer = Answer.find(ids[i])
              @answer.content = contents[i]
              @answer.sign = signs[i]
              @answer.subject_id = @subject.id
              @answer.save!
            }
          end
          redirect_to action: :index
        end
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

