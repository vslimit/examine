class User < ActiveRecord::Base
  attr_accessible :air, :card_no, :exam_date, :name, :reason, :score, :status,:on_line,:session_id

  has_many :scores


end
