class ApplicationController < ActionController::Base
    include Pundit
    before_action :set_search

    def set_search
        @q = Product.search(params[:q])
    end
end
