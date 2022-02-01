class OrderItemsController < ApplicationController
  before_action :set_order
  before_action :set_product, only: [:create, :update]
  def create
    order_item = @order.order_items.find_by(product_id: order_params[:product_id])
    
    new_quantity = order_item ? order_item.quantity + order_params[:quantity].to_i : order_params[:quantity].to_i
    if order_item && set_product.stock >= new_quantity
      order_item.update(quantity: new_quantity)

    
    elsif !order_item && set_product.stock >= new_quantity
      @order.order_items.new(order_params)
      @order.save

    else
        @error = "Invalid quantity"
    end
  end

  def update
    @order_item = @order.order_items.find(params[:id])

    new_quantity = @order_item.quantity + order_params[:quantity].to_i
    if set_product.stock >= new_quantity
      @order_item.update(order_params)
    end

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

  def set_product
    product = Product.find(order_params[:product_id])
  end

  def set_order
    @order = current_order
  end

  def order_params
    params.require(:order_item).permit(:product_id, :quantity)
  end
end