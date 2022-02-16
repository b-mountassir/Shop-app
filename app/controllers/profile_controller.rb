class ProfileController < ApplicationController

    def show
        @user = User.find_by(username: params[:username])
        @pagy, @reviews = pagy(@user.reviews)
    end
end