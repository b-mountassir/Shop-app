class Seller::UserPolicy < UserPolicy
    def index?
        @user.has_role?(:seller) || @user.has_role?(:admin)
    end
    
end