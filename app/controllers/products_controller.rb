class ProductsController < ApplicationController
    def index
        @category = Category.friendly.find(params[:category_id])
        @pagy, @products = pagy(@category.products)
    end
    def show 
        @product = Product.friendly.find(params[:id])
    end
    
    def search
        @q = Product.ransack(params[:q])
        @pagy, @products = pagy(@q.result(distinct: true))
    end

    
end