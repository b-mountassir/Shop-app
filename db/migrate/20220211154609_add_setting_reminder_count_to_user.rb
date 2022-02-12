class AddSettingReminderCountToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :reminder_count, :int, default: 3
  end
end
