class OrdersController < ApplicationController
    before_action :authenticate_user!
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
          error = err
          raise ActiveRecord::Rollback
        end
      end

      redirect_to cart_path and return  if error != nil
      order = current_order
      if current_order.update(status: 'ordered')
        
        OrderMailer.with(order: order).order_confirmation_email.deliver_later
        
        # EmailingJob.perform_later(order)
        # session.delete(:order_id)
        flash[:notice] = "Order created successfully"
        redirect_to categories_path
      else
        flash[:notice] = "something wrong happened"
        redirect_to cart_path
      end
    end
    
    def index
      @orders = Order.closed_orders.where(user_id: current_user.id)
    end
    

    def show
        @order = Order.find(params[:id])
        redirect_to root_path and return if @order.user != current_user
    end
  end