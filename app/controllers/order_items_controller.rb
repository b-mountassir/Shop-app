class OrderItemsController < ApplicationController
  before_action :set_order
  def create
    order_item = @order.order_items.find_by(product_id: order_params[:product_id])
    if order_item
      order_item.update(quantity: order_item.quantity + order_params[:quantity].to_i)
    else
      @order.order_items.new(order_params)
      @order.save
    end
    respond_to do |format|
        format.js
    end
  end

  def update
    @order_item = @order.order_items.find(params[:id])
    @order_item.update(order_params)
    @order_items = current_order.order_items
  end

  def destroy_all
    OrderItem.delete_by(order_id: @order.id)
    @order_items = @order.order_items
  end

  def destroy
    @order_item = @order.order_items.find(params[:id])  
    @order_item.destroy! 
    @order_items = current_order.order_items 
  end

  private 

  def set_order
    @order = current_order
  end

  def order_params
    params.require(:order_item).permit(:product_id, :quantity)
  end
end