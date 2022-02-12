class ReminderEmailJob < ApplicationJob
    queue_as :default
    sidekiq_options retry: 1
  
    def perform(order_item)
      ReminderReview.with(item: order_item).send_reminder_email.deliver_later
    end
  end
  