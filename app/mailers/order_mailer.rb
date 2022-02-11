class OrderMailer < ApplicationMailer
    def order_confirmation_email
        @order = params[:order]
        mail(to: @order.user.email, subject: "Order #{@order.id} confirmation")
    end
end
