class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    alias_action :create, :read, :update, :destroy, :to => :crud

    user ||= User.new(role: 'guest') # guest user (not logged in)
    # can :read, :all
    if user.role? :guest
      can :read, User
      can :read, Event
      can :read, Location
      can :read, Category
    end
    if user.role? :user
      can [:create, :update, :read], User
      cannot :destroy, user
      can :read, Event
      can :read, Location
      can :read, Category
    end
    if user.role? :admin
      can :manage, User
      can :manage, Event
      can :manage, Location
      cannot :manage, Category
      cannot :destroy, User, :id => user.id
      cannot :manage, User, role: "super_admin"
      cannot :manage, User, role: "admin"
    end
    if user.role? :super_admin
      can :manage, :all
      cannot :destroy, User, :id => user.id
    end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
