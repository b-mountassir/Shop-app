class Admin::CategoriesController < Admin::BaseController
    before_action :set_category, only: [:show, :edit, :update, :destroy ]
    
    def new
        @category = Category.new
        authorize @category
    end
    def create
        @category = Category.new(category_params)
        authorize @category
        respond_to do |format|
            if @category.save and current_user.has_role? :admin
              format.html { redirect_to category_products_url(@category), notice: "Category was successfully created." }
            else
              format.html { render :new, status: :unprocessable_entity }
            end
        end
    end

    def edit
        authorize @category
    end

    def update
        authorize @category
        respond_to do |format|
            if @category.update(category_params) and current_user.has_role? :admin
              format.html { redirect_to category_products_url(@category), notice: "Category was successfully created." }
            else
              format.html { render :new, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        authorize @category
        @category.destroy
        respond_to do |format|
            format.html { redirect_to root_path, notice: "Category was successfully destroyed." }
        end
    end
    
    private
    def set_category
        @category = Category.friendly.find(params[:id])
    end
    def category_params
        params.require(:category).permit(:name)
    end
end
