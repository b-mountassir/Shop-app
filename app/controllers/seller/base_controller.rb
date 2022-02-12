class Seller::BaseController < ApplicationController
    before_action :authenticate_user!
    def policy_scope(scope)
        super([:seller, scope])
    end
    
    def authorize(record, query = nil)
        super([:seller, record], query)
    end
end