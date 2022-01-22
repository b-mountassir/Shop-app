class Admin::CategoriesController < ApplicationController
    before_action :authenticate_user!
    def new
        @category = Category.new
    end
    def create
        @category = Category.new(product_params)
        respond_to do |format|
            if @category.save or current_user.has_role? :admin
              format.html { redirect_to admin_category_url(@product), notice: "Category was successfully created." }
            else
              format.html { render :new, status: :unprocessable_entity }
            end
        end
    end

    private

    def product_params
        params.require(:category).permit(:name)
    end
end
