class Score < ActiveRecord::Base
  # attr_accessible :air, :all_score, :exam_date,:examine_date, :reason, :status, :subjects, :totle_score, :user_id

  belongs_to :category
  belongs_to :user
end
