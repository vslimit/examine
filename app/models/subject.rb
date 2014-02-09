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


  def self.create_subject!(title, air, answer, category_id, subject_type, signs, contents)
    code = Category.find(category_id).code << '::' << subject_type
    Subject.transaction do
      subject = Subject.new title: title, air: air, answer: answer, category_id: category_id, subject_type: subject_type, code: code
      subject.save!
      unless subject_type == 'true-false'
        if !contents.blank? && contents.length > 0
          contents.each_index { |i|
            @answer = Answer.new
            @answer.content = contents[i]
            @answer.sign = signs.include?((i).to_s) ? 'Y' : 'N'
            @answer.subject_id = subject.id
            @answer.sign_id = i
            @answer.save!
          }
        end
      end
      return subject
    end
  end

  def self.update_subject!(id,title, air, answer, category_id, subject_type, signs, contents)
    code = Category.find(category_id).code << '::' << subject_type
    Subject.transaction do
      subject = Subject.find(id)
      #subject = Subject.new title: title, air: air, answer: answer, category_id: category_id, subject_type: subject_type, code: code
      subject.title = title
      subject.air = air
      subject.answer = answer
      subject.category_id = category_id
      subject.subject_type = subject_type
      subject.code = code
      subject.save!

      unless subject_type == 'true-false'
        subject.answers.delete_all # 一次砍掉 e 的所有 attendees，不會觸發個別 attendee 的 destroy 回呼
        if !contents.blank? && contents.length > 0
          contents.each_index { |i|
            @answer = Answer.new
            @answer.content = contents[i]
            @answer.sign = signs.include?((i).to_s) ? 'Y' : 'N'
            @answer.subject_id = subject.id
            @answer.sign_id = i
            @answer.save!
          }
        end
      end
      return subject
    end
  end

end
