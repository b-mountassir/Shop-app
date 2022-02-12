class CategoriesController < ApplicationController
  def index
    @categories = Category.friendly.order(:name)
  end
  def home
    @categories = Category.last(4)
    @home_page = "home"
  end
end
