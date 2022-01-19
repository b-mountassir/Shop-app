class Product < ApplicationRecord
    validates_presence_of :price, :name, :stock
    has_rich_text :description

    has_many :product_categories
    has_many :categories, through: :product_categories
end
