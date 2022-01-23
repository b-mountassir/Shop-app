class Product < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: %i(slugged history finders)
    validates_presence_of :price, :title, :stock, :categories
    has_rich_text :description

    has_many :product_categories
    has_many :categories, through: :product_categories

    belongs_to :seller, class_name: 'User'

    def should_generate_new_friendly_id? #will change the slug if the name changed
        title_changed?
    end
end
