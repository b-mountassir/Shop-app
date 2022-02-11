class AddRevuiewAtToOrderItem < ActiveRecord::Migration[6.1]
  def change
      add_column :order_items, :reviewed_at, :datetime
  end
end
