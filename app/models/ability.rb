class Ability
  include CanCan::Ability
  
  def initialize(user)
    @user = user
    
    if @user.admin?
      can :manage, :all
    else
      can [:create, :read], ServiceRequest, company_id: @user.company_id
      can :manage, Customer, company_id: @user.company_id
    end
  end
end