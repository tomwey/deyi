class Ability
  include CanCan::Ability
  
  def initialize(user)
    # can :manage, Post
    # can :read, User
    # can :manage, User, id: user.id
    can :manage, ActiveAdmin::Page, name: "Dashboard"#, namespace_name: :admin
    if user.super_admin?
      can :manage, :all
    else
      can :read, :all
      cannot :read, SiteConfig
    end
    
  end
end