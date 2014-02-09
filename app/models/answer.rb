class Answer < ActiveRecord::Base
  attr_accessible :content, :sign, :subject_id,:sign_id
  belongs_to :subject

end
