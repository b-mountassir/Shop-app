class OrderItem < ApplicationRecord
    before_save :set_unit_price 
    before_save :set_total
    belongs_to :seller_order, optional: true
    validates :quantity, numericality: { greater_than: 0 }
    belongs_to :user, optional: true
    belongs_to :order
    belongs_to :product
    
    def unit_price
        # If there is a record
        if persisted?
          self[:unit_price]
        else
          product.price
        end
    end

    def total
        return unit_price * quantity
    end

    private

    def set_unit_price
        self[:unit_price] = unit_price
    end
        
    def set_total
        self[:total] = total 
    end
end
