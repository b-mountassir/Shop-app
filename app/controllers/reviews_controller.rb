class ReviewsController < ApplicationController
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!, only: [:create]
    error = 201
    def create
        # check order item belongs to user???
        @order_item = OrderItem.find_by(user_id: current_user.id, id: review_params[:order_item_id], reviewed_at: nil)
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
            error = 500
        end
    end

    def create_from_email
        # check order item belongs to user???
        @order_item = OrderItem.find_by(id: review_params[:order_item_id], reviewed_at: nil)
        jwt_data = JWT.decode review_params[:authorization_token], ENV['SECRET_KEY'], true, { algorithm: 'HS256'}
        user = User.find(jwt_data.first.first[1])
        if !user 
            flash[:alert] = "Unauthorized"

            redirect_to(root_url) and return
        end
        if @order_item.nil? 
            flash[:alert] = "Review failed"
            redirect_to(root_url) and return
        end
        @review =  Review.new(
            title: review_params[:title],
            body: review_params[:body],
            rating: review_params[:rating],
            reviewer: user,
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
        redirect_to product_url(@order_item.product)
    end
    
    def edit
        @review = current_user.reviews.find(params[:id])
        new_review = @review
    end

    def update 
        @review = current_user.reviews.find(params[:id])
        respond_to do |format|
            if @review.update(review_params.except(:dummy_variable))
                format.html { redirect_to(request.referrer) }
                flash[:notice] = "Review was successfully updated." 
            else
                format.html { render :edit, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @review = current_user.reviews.find(params[:id])
        @review.destroy
        @review.order_item.update(reviewed_at: nil)
    end

    private

    def review_params
        params.require(:review).permit(:title, :body, :rating, :order_item_id, :authorization_token, :dummy_variable)
    end

    
end