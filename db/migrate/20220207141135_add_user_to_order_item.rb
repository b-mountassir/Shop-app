class AddUserToOrderItem < ActiveRecord::Migration[6.1]
  def change
    add_reference  :order_items, :user, index: true
  end
end
