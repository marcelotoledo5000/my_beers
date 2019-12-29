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

  def can_destroy(user)
    can :destroy, Pub do |pub|
      pub&.user == user
    end
    can :destroy, Style do |style|
      style&.user == user
    end
    can :destroy, Beer do |beer|
      beer&.user == user
    end
  end

  def can_update(user)
    can :update, Pub do |pub|
      pub&.user == user
    end
    can :update, Style do |style|
      style&.user == user
    end
    can :update, Beer do |beer|
      beer&.user == user
    end
  end

  def can_execute(user)
    can_create
    can_update(user)
    can_destroy(user)
  end
end
