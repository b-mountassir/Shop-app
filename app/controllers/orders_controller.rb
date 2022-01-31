class OrdersController < ApplicationController
  
    def create
    
      if current_order.update(status: 'ordered')
        # session.delete(:order_id)
        flash[:notice] = "Order created successfully"
        redirect_to categories_path
      else
        flash[:error] = "something wrong happened"
        redirect_to cart_path
      end
    end
    
    def show
        @order = Order.find(params[:id])
        redirect_to root_path and return if @order.user != current_user
    end
  end