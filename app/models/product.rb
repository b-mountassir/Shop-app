class Product < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: :slugged
    validates_presence_of :price, :title, :stock
    has_rich_text :description

    has_many :product_categories
    has_many :categories, through: :product_categories

    belongs_to :seller, class_name: 'User'
end
