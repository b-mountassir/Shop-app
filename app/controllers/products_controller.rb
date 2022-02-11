class ProductsController < ApplicationController
    before_action :set_category, only: :show
    before_action :set_new_review, only: :show

    def index        
        unless params.has_key?(:q)
            @category = Category.friendly.find(params[:category_id])
            @pagy, @products = pagy(@category.products.order(:title), items: 9)
        else
            @q = Product.ransack(params[:q])
            puts params[:q]
            @pagy, @products = pagy(@q.result(distinct: true), items: 20)
        end
    end
    def show 
        unless defined?(@product)
            @product = @category.products.find(params[:id])
        end
        
        
        @review_count = @product.reviews.count
        if @review_count > 0
            @pagy, @reviews = pagy(@product.reviews.order("created_at DESC"), items: 5)
            @average_rating = (@product.reviews.collect { |review|  review.rating.to_i }.sum)/@review_count.to_f if @review_count > 0
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
    
    def set_new_review
        
        if user_signed_in?
             @order_item = current_user.order_items.find_by(product: @product, reviewed_at: nil)
        end
        @new_review = nil
        if !@order_item.nil?
            @new_review = @product.reviews.new(order_item_id: @order_item.id)
        end
    end

end