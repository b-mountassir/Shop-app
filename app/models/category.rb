class Category < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: :slugged
    has_many :product_categories
    has_many :products, through: :product_categories, dependent: :destroy
end
