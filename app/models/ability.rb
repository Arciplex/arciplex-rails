class Ability
    include CanCan::Ability

    def initialize(user)
        @user = user

        @user.permissions.each do |permission|
            if permission.subject_class.present?
                can permission.action.to_sym, permission.subject_class.constantize do |sc|
                    @user.company_ids.include? sc.company_id
                end
            else
                can permission.action.to_sym, permission.custom_subject.to_sym
            end
        end
    end
end
