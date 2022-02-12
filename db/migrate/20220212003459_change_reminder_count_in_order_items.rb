class ChangeReminderCountInOrderItems < ActiveRecord::Migration[6.1]
  def change
    change_column :order_items, :reminder_count, :integer, default: 0
  end
end
