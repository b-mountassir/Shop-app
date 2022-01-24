class Order < ApplicationRecord
    
    belongs_to :user
    has_many :order_items

    enum status: { cart: 0, ordered: 1, paid: 2}
end
