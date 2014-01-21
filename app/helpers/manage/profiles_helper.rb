#encoding:utf-8
module Manage
  module ProfilesHelper
    def profile_type_list
      [
          ['题型设置', Profile::SUBJECT_TYPE],
          ['考试设置', Profile::EXAMINE_PROFILE],
      ]
    end

    def subject_type_list
      subject_types = []
      Profile.where(dic_type: Profile::SUBJECT_TYPE).all.each do |a|
        subject_types.push [a.dic_value, a.dic_key]
      end
      subject_types
    end
  end
end