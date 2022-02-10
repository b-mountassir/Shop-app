class ReviewsController < ApplicationController
    before_action :authenticate_user!
    def create
        # check order item belongs to user???
        @order_item = OrderItem.find_by(id: review_params[:order_item_id], reviewed_at: nil)
        if @order_item.nil? 
            flash[:error] = "Review failed"
            redirect_to(request.referrer || root_path) and return
        end
        @review =  Review.new(
            title: review_params[:title],
            body: review_params[:body],
            rating: review_params[:rating],
            reviewer: current_user,
            product: @order_item.product,
            order_item: @order_item
        )
        if @review.save!
            @order_item.reviewed_at = @review.created_at
            @order_item.save!
            flash[:notice] = "Review successfully created"
        else
            flash[:error] = "Review failed"
        end
        
    end
    
    private

    def review_params
        params.require(:review).permit(:title, :body, :rating, :order_item_id)
    end
    
end