class CategoriesController < ApplicationController
  def index
    @categories = Category.friendly.order(:name)
  end
end
