#encoding:utf-8
module Manage
  module SubjectsHelper
    def true_or_false_list
      [
          ['正确', Subject::YES],
          ['错误', Subject::NO]
      ]
    end

    def air_list
      [
          %w(全部 A320,A330),
          %w(A320 A320),
          %w(A330 A320)
      ]
    end
  end
end