class OrdersController < ApplicationController
  
    def create
      # # take snapshot
      # current_order.order_items.each do |order_item|
      #   product = order_item.product
      #
      #   product.update(stock: product.stock - order_item.quantity) # race condition!
      #   # rescue to the saved snapshot
      # end
      #
      error = nil
      ActiveRecord::Base.transaction do
        begin
          current_order.order_items.each do |order_item|
            product = order_item.product
            product.update!(stock: product.stock - order_item.quantity) # race condition!
          end
        rescue ActiveRecord::RecordInvalid => err
          flash[:notice] = "Invalid stock, check your cart again"
          puts "BILALLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL", err
          error = err
          raise ActiveRecord::Rollback
        end
      end

      redirect_to cart_path and return  if error != nil

      if current_order.update(status: 'ordered')
        # session.delete(:order_id)
        flash[:notice] = "Order created successfully"
        redirect_to categories_path
      else
        flash[:notice] = "something wrong happened"
        redirect_to cart_path
      end
    end
    
    def show
        @order = Order.find(params[:id])
        redirect_to root_path and return if @order.user != current_user
    end
  end