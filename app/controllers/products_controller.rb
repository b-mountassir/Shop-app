class ProductsController < ApplicationController
    before_action :set_category, only: :show

    def index        
        unless params.has_key?(:q)
            @category = Category.friendly.find(params[:category_id])
            @pagy, @products = pagy(@category.products.order(:title))
        else
            @q = Product.ransack(params[:q])
            puts params[:q]
            @pagy, @products = pagy(@q.result(distinct: true))
        end
    end
    def show 
        unless defined?(@product)
            @product = @category.products.find(params[:id])
        end
        
        @new_review = @product.reviews.new
        
        @review_count = @product.reviews.count
        if @review_count > 0
            @reviews = @product.reviews
            @average_rating = (@product.reviews.collect { |review|  review.rating.to_i }.sum)/@review_count if @review_count > 0
        end
    end
    

    private 

    def set_category
        if params.has_key?(:category_id)
            @category = Category.friendly.find(params[:category_id])
        else
            @product = Product.friendly.find(params[:id])
            @category = @product.categories.first
        end
    end


end