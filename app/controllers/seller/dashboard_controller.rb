class Seller::DashboardController < Seller::BaseController
    def index
        seller = authorize current_user

        @pagy, @products = pagy(seller.products, items: 9)
    end
    
end
