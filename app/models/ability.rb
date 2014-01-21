class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Admin.new
    if user.has_role? Admin::SUPER_ADMIN
      can :manage, :all
    elsif user.has_role? Admin::ADMIN
      can :manage, Category
      can :manage, Profile
    end
  end

end
