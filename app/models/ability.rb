class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user

    if @user.admin?
      can :manage, :all
    else
      if @user.restricted?
        can :read, ServiceRequest, company_id: @user.company_id
      else
        can [:create, :read], ServiceRequest, company_id: @user.company_id
      end
      can [:create, :read], Order, company_id: @user.company_id
      can :manage, Customer, company_id: @user.company_id
    end
  end
end
