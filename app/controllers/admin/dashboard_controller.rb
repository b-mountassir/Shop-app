class Admin::DashboardController < Admin::BaseController
    before_action :verify_admin
    def index
        @users = User.order(:email)
    end

    private

    def verify_admin
        admin = authorize current_user
    end
end