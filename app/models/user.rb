class User < ActiveRecord::Base
  # attr_accessible :card_no, :name, :status,:on_line,:session_id

  USER_STATUS = [ON ='on',OFF='off']
  has_many :scores


end
