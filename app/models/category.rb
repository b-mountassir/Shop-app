class Category < ApplicationRecord
    extend FriendlyId
    friendly_id :name, use: %i(slugged history finders)
    has_many :product_categories
    has_many :products, through: :product_categories, dependent: :destroy
    def should_generate_new_friendly_id? #will change the slug if the name changed
        name_changed?
    end
end
