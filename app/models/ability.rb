# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    return if user.nil?

    if user.admin?
      can :manage, :all
    else
      can :read, :all
      can_execute(user) if user.default?
    end
  end

  private

  def can_create
    can :create, Pub
    can :create, Style
    can :create, Beer
  end

  def can_do_it(user, action)
    can action, Pub, user_id: user.id
    can action, Style, user_id: user.id
    can action, Beer, user_id: user.id
  end

  def can_execute(user)
    can_create
    can_do_it(user, :update)
    can_do_it(user, :destroy)
  end
end
