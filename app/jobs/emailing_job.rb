class EmailingJob < ApplicationJob
  queue_as :default
  sidekiq_options retry: 5

  def perform(order)
    OrderMailer.with(order: order).order_confirmation_email.deliver_now
  end
end
