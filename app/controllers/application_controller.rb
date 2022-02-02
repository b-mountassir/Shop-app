class ApplicationController < ActionController::Base
    
    before_action :configure_permitted_parameters, if: :devise_controller?
    include Pundit
    include Pagy::Backend
    include ApplicationHelper
    
    before_action :set_search

    def set_search
        @q = Product.search(params[:q])
    end

    protected

    def configure_permitted_parameters
        added_attrs = [:username, :email, :password, :password_confirmation, :remember_me, :profile_picture, :first_name, :last_name, [roles:[]]]
        devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
        devise_parameter_sanitizer.permit :sign_in, keys: [:login, :password]
        devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    end
end
