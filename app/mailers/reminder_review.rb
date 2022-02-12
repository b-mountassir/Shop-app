class ReminderReview < ApplicationMailer
    def send_reminder_email
        @item = params[:item]
        @new_review = Review.new
        @jwt = JWT.encode({id: @item.user.id}, ENV['SECRET_KEY'], 'HS256')
        mail(to: @item.user.email, subject: "Please review your purchase of #{@item.product.title}")
    end
end
