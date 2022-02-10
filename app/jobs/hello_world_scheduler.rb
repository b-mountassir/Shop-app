require 'sidekiq-scheduler'

class HelloWorldScheduler 
  include Sidekiq::Worker

  def perform
    puts 'Hello world every minute'
  end
end