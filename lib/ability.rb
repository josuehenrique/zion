class Ability
  include CanCan::Ability

  def initialize(user = nil)
    alias_action :modal, to: :read
    alias_action :new, to: :create
    alias_action :edit, to: :update

    return unless user

    if user.admin?
      can :access, :all
    else
      can :modal, :all

      user.user_permits.each do |role|
        can role.action.to_sym, role.controller.to_sym
      end
    end
  end
end
