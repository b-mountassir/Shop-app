class Admin::DashboardController < Admin::BaseController
    before_action :verify_admin
    def index
        admin = current_user
        @users = User.order(:email)
        authorize admin
    end

    private

    def verify_admin
        if current_user.has_role?(:admin)
            return
        end
    end
end