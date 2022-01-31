class ApplicationController < ActionController::Base
    include Pundit
    include Pagy::Backend
    include ApplicationHelper
    
    before_action :set_search

    def set_search
        @q = Product.search(params[:q])
    end
end
