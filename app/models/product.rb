class Product < ApplicationRecord
    extend FriendlyId
    friendly_id :title, use: %i(slugged history finders)
    validates_presence_of :price, :title, :stock, :categories
    validates :stock, numericality: { greater_than_or_equal_to: 0 }
    has_rich_text :description
    has_one_attached :product_picture
    has_many :product_categories, dependent: :destroy
    has_many :categories, through: :product_categories
    has_many :reviews, dependent: :destroy

    belongs_to :seller, class_name: 'User'
    
    default_scope -> { where(deleted_at: nil) }
    scope :with_deleted, -> { unscope(where: :deleted_at) }
    scope :only_deleted, -> { with_deleted.where.not(deleted_at: nil) }
    
    scope :published, -> { where(published: true) }
    scope :onsale, -> { where(on_sale: true) }

    define_model_callbacks :soft_destroy

    def soft_destroy
        run_callbacks :soft_destroy do
            update_column("deleted_at", Time.now)
        end
    end

    def should_generate_new_friendly_id? #will change the slug if the name changed
        title_changed?
    end
end
