class UserPolicy
    include ApplicationHelper
  
    attr_reader :current_user, :model
  
    def initialize(current_user, model)
      @current_user = current_user
      @user = model
    end
  
    def index?
      @current_user.has_role? :admin
    end
  
    def show?
        @current_user.has_role? :admin or @current_user == @user
    end
  
    def update?
        @current_user.has_role? :admin or @current_user == @user 
    end
  
    def destroy?
        @current_user.has_role? :admin or @current_user == @user
    end
  
  end