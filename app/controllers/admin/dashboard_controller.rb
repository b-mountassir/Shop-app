class Admin::DashboardController < Admin::BaseController
    before_action :verify_admin
    def index
        @users = User.order(:email)
        data_category = ActiveRecord::Base.connection.exec_query("SELECT product_categories.category_id, SUM(order_items.total) 
                                                            FROM order_items 
                                                            JOIN product_categories 
                                                            ON order_items.product_id = product_categories.product_id 
                                                            INNER JOIN orders ON orders.id = order_items.order_id 
                                                            WHERE orders.status = 1 
                                                            GROUP BY product_categories.category_id;")
        @categories = Category.all
        @data_keys = []
        data_category.rows.to_h.keys.each do |key|
            @data_keys << Category.find(key).name

        end
        @data_values = data_category.rows.to_h.values
        @data_colors = []
        data_category.rows.to_h.keys.each do |key|
            @data_colors << 'rgb(' + (rand(1...255)).to_s + ',' + (rand(1...255)).to_s + ',' + (rand(1...255)).to_s + ')'
        end

        data_daily_orders = ActiveRecord::Base.connection.exec_query("select to_char(updated_at, 'YYYY-MM-DD'), sum(subtotal)
                                from orders
                                where orders.status = 1
                                group by to_char(updated_at, 'YYYY-MM-DD')
                                order by 1;")
        
        @data_values_daily_orders = data_daily_orders.rows.to_h.values
        @data_keys_daily_orders = data_daily_orders.rows.to_h.keys

    end

    private

    def verify_admin
        admin = authorize current_user
    end
end