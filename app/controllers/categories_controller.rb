class CategoriesController < ApplicationController
  def index
    @categories = Category.friendly.order(:name)
  end
  def home
    @category = Category.first(4).first
    @products = @category.products.last(5)
  end
end
