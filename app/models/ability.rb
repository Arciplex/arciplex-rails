class Ability
  include CanCan::Ability
  
  def initialize(user)
    @user = user
    
    if @user.has_role? :superadmin
      can :manage, :all
    elsif @user.has_role? :requestor
      can :manage, ServiceRequest, user_id: @user.id
      can :manage, Customer, company_id: @user.company_id
    end
  end
end