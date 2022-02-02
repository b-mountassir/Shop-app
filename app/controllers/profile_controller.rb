class ProfileController < ApplicationController

    def show
        if user_signed_in?
            @user = current_user
    
        end
    end
end