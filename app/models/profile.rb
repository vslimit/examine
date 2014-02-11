#encoding:utf-8
class Profile < ActiveRecord::Base
  attr_accessible :dic_key, :dic_value, :dic_type,:dic_type_name

  DIC_TYPES = [SUBJECT_TYPE = 'subject_type',SUBJECT_PROFILE ='subject_profile',SCORE_PROFILE ='score_profile',EXAMINE_PROFILE ='examine_profile']
  TYPE_MAP = {
      SUBJECT_TYPE => '题型',
      SUBJECT_PROFILE => '题目设置',
      SCORE_PROFILE => '分数设置',
      EXAMINE_PROFILE => '考试设置',
  }

  class << self
     def dic_val(dic_key)
       Profile.find_by_dic_key(dic_key).dic_value
     end
  end
end
