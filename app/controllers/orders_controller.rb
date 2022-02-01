class OrdersController < ApplicationController
  
    def create
      
      puts "MOUNTASSIR CHOUF HNA"
      current_order.order_items.each do |order_item| 
        product = order_item.product
        puts order_item.product, "chof hna"
        product.stock -= order_item.quantity
        product.save
      end
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