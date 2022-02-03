class ReviewsController < ApplicationController
    before_action authenticate_user!
    def create
        @product = Product.friendly.find(review_params[:product_id])
        @review =  @product.reviews.new(review_params)
        if @review.save
            flash[:notice] = "Review successfully created"
        else
            flash[:error] = "Review failed"
        end
    end
    
    private

    def review_params
        params.require(:review).permit(:title, :body, :rating, :reviewer_id, :product_id)
    end
    
end