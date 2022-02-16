class ApplicationController < ActionController::Base
    
    before_action :configure_permitted_parameters, if: :devise_controller?
    include Pundit
    include Pagy::Backend
    include ApplicationHelper
    before_action :set_categories
    
    before_action :set_search
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

    def set_search
        @q = Product.ransack(params[:q])
    end

    def set_categories
        @categoies_nav = Category.order(:name)
    end

    private
    def user_not_authorized
       flash[:notice] = "Sorry, You Are Not Authorized To Do This"
       redirect_to(request.referrer || root_path)
    end
    protected

    def configure_permitted_parameters
        added_attrs = [:username, :email, :password, :password_confirmation, :remember_me, :profile_picture, :first_name, :last_name, [roles:[]]]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
        devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end
end
