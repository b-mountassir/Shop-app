require 'sidekiq-scheduler'

class ReminderReviewEmailScheduler 
  include Sidekiq::Worker

  def perform
    OrderItem.joins(:user).where('reviewed_at is ? AND order_items.reminder_count < users.reminder_count', nil).each do |oi|
        ReminderEmailJob.perform_later(oi)
        oi.update(reminder_count: oi.reminder_count + 1)
    end
  end
end