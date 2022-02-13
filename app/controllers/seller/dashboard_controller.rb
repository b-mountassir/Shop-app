class Seller::DashboardController < Seller::BaseController
    before_action :authorize_seller

    def index
        @pagy, @products = pagy(authorize_seller.products, items: 9)
    end
    
    def show 
        @orders = SellerOrder.all.where(seller_id: authorize_seller.id)
    end

    private

    def authorize_seller
        seller = authorize current_user
    end

end
