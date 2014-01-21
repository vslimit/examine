#encoding:utf-8
class Profile < ActiveRecord::Base
  attr_accessible :dic_key, :dic_value, :dic_type,:dic_type_name

  DIC_TYPES = [SUBJECT_TYPE = 'subject_type',EXAMINE_PROFILE ='examine_profile']
  TYPE_MAP = {
      SUBJECT_TYPE => '题型',
      EXAMINE_PROFILE => '考试设置'
  }

  class << self
     def dic_val(dic_key)
       Profile.find_by_dic_key(dic_key).dic_value
     end
  end
end
