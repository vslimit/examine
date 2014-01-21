#encoding:utf-8
class Subject < ActiveRecord::Base
  attr_accessible :air, :answer, :category_id, :code, :title, :subject_type, :tag

  belongs_to :category
  has_many :answers, dependent: :destroy
  TRUE_OR_FALSE_AWS = [YES = 'yes', NO ='no']
  TRUE_OR_FALSE_AWS_MAP = {
      YES => '正确',
      NO => '错误'
  }


  def self.create_subject!(title,air, answer, category_id, subject_type, signs, contents)
    code = Category.find(params[:category_id]).code << '::' << params[:subject_type]
    Subject.transaction do
      subject = Subject.new title: title,air: air, answer: answer, category_id: category_id, subject_type: subject_type, code:code
      subject.save!
      unless subject_type == 'true-false'
        contents.each do |content|
          message_expand = MessageExpand.new
          message_expand.from= from
          message_expand.to = user_id
          message_expand.status=MessageExpand::COMMON
          message_expand.message = message
          message_expand.save!
        end
      end
      return subject
    end
  end

end
