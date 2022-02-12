class AddReferenceSellerOrderToOrderItem < ActiveRecord::Migration[6.1]
  def change
    add_reference :order_items, :seller_order
  end
end
