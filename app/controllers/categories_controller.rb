class CategoriesController < ApplicationController
  def index
    @categories = Category.friendly.order(:name)
  end
  def home
    @category = Category.find(20)
    @products = @category.products.last(5)
  end
end
