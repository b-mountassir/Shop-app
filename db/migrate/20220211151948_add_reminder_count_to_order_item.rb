class AddReminderCountToOrderItem < ActiveRecord::Migration[6.1]
  def change
          add_column :order_items, :reminder_count, :int, default: 3
  end
end
