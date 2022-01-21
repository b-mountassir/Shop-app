class Category < ApplicationRecord
    resourcify
    belongs_to :admin, class_name: 'User'
    extend FriendlyId
    friendly_id :name, use: :slugged
    has_many :product_categories
    has_many :products, through: :product_categories, dependent: :destroy
end
