class AddOrderItemToReview < ActiveRecord::Migration[6.1]
  def change
    add_reference  :reviews, :order_item, index: true

  end
end
