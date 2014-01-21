#encoding:utf-8
module Manage
  module AdminsHelper
    def role_list
      [
          ['超级管理员', Admin::SUPER_ADMIN],
          ['管理员', Admin::ADMIN]
      ]
    end

    def role_text(role)
      case role
        when Admin::ADMIN
          '管理员'
        when Admin::SUPER_ADMIN
          '超级管理员'
      end
    end
  end
end
