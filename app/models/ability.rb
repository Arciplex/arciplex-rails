class Ability
  include CanCan::Ability

  def initialize(user)
    @user = user

    if @user.admin? || @user.has_role?(:shipping_vendor)
      can :manage, :all
    else
      if @user.restricted?
        can :read, ServiceRequest do |sr|
          @user.company_ids.include?(sr.company_id)
        end
      else
        can [:create, :read], ServiceRequest do |sr|
          @user.company_ids.include?(sr.company_id)
        end
      end
      can [:create, :read], Order do |order|
        @user.company_ids.include?(order.company_id)
      end
      can :manage, Customer do |cust|
        @user.company_ids.include?(cust.company_id)
      end
    end
  end
end
