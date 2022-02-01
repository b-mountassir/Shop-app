class Admin::DashboardController < Admin::BaseController
    def index
        @users = User.order(:email)
    end
end