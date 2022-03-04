module ApplicationHelper
    include Pagy::Frontend

    def current_order
        if current_user
          unless cookies.has_key?("cart")
            exist_cart = Order.find_by(user_id: current_user.id, status: "cart") 
          else 
            cookie_order = Order.find(cookies[:cart])
            puts cookie_order.status
            if cookie_order.status == "cart"
              cookie_order.update(user_id: current_user.id)
              exist_cart = cookie_order
              flash[:notice] = "your old cart"
            end
          end
          if exist_cart.nil?
            Order.create(user_id: current_user.id, status: "cart")
          else
            exist_cart
          end
        elsif !user_signed_in? 
          exist_cart_unauthenticated = Order.find_by(id: cookies[:cart], status: "cart") unless cookies[:cart].nil?
          puts exist_cart_unauthenticated
          if exist_cart_unauthenticated.nil?
            order_unauthenticated = Order.create(status: "cart")
            cookies[:cart] = order_unauthenticated.id
            return order_unauthenticated
          else
            exist_cart_unauthenticated
          end
        end
    end
end
