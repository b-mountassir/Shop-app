class SellerOrder < ApplicationRecord
    belongs_to :order
    belongs_to :buyer, class_name: 'User'
    belongs_to :seller, class_name: 'User'
    has_many :order_items
end
