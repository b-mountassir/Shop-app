class Review < ApplicationRecord
    validates :product_id, :presence => true
    validates_length_of :body, minimum: 10, maximum: 250
    validates_numericality_of :rating, less_than_or_equal_to: 5, greater_than_or_equal_to: 1, :presence => true
    belongs_to :product
    belongs_to :reviewer, class_name: 'User'
end