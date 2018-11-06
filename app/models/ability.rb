class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.nil?

    if user.admin?
      can :manage, :all
    else
      can :read, :all
      if user.default?
        can :create, Pub
        can :create, Style
        can :create, Beer
        can :update, Pub do |pub|
          pub.try(:user) == user
        end
        can :update, Style do |style|
          style.try(:user) == user
        end
        can :update, Beer do |beer|
          beer.try(:user) == user
        end
        can :destroy, Pub do |pub|
          pub.try(:user) == user
        end
        can :destroy, Style do |style|
          style.try(:user) == user
        end
        can :destroy, Beer do |beer|
          beer.try(:user) == user
        end
      end
    end
  end
end
