class Order < ApplicationRecord
    before_save :set_subtotal
    
    belongs_to :user
    has_many :order_items

    enum status: { cart: 0, ordered: 1, paid: 2}
    scope :closed_orders, -> { where(status: 'ordered') }
    def subtotal
        order_items.collect { |order_item| order_item.valid? ? order_item.unit_price * order_item.quantity : 0 }.sum
    end

    def count_subitems
        order_items.collect { |order_item| order_item.valid? ? order_item.quantity : 0 }.sum
    end

    private

    def set_subtotal
        self[:subtotal] = subtotal
    end
end
