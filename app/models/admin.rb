class Admin < ActiveRecord::Base
  # attr_accessible :login,:name, :password, :role

  ROLE_NAMES = [SUPER_ADMIN = 'super_admin', ADMIN = 'admin']

  has_secure_password

  def has_role?(role)
    role == role
  end
end
