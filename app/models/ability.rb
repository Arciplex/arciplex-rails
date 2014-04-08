class Ability
  include CanCan::Ability
  
  def initialize(user, company_id)
    @user = user
    
    if @user.admin?
      can :manage, :all
      can :manage, ServiceRequest, company_id: company_id unless company_id.nil?
    else
      can [:create, :read], ServiceRequest, company_id: @user.company_id
      can :manage, Customer, company_id: @user.company_id
    end
  end
end