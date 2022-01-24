class Seller::ProductsController < Seller::BaseController
    before_action :authenticate_user!, only: [:new, :create, :edit, :destroy, :update] ## require user to login 
    before_action :set_product, only: [:show, :edit, :update, :destroy ]
    def new
        @product = Product.new
        @category = Category.friendly.find(params[:categories])
        authorize @product
    end

    def edit
        authorize @product
        
        @category = @product.categories.first
    end

    def create
       
        @product = Product.new(product_params)
        @product.seller = current_user
        authorize @product
        puts params
        respond_to do |format|
            if @product.save
                format.html { redirect_to edit_seller_product_path(@product), notice: "Product was successfully created." }
            else
                format.html { render :new, status: :unprocessable_entity }
            end
        end
    end

    def update
        params[:product][:category_ids] ||= []
        authorize @product
        
        respond_to do |format|
            if @product.update(product_params)
                format.html { redirect_to edit_seller_product_url(@product), notice: "Product was successfully updated." }
            else
                format.html { render :edit, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        authorize @product
        @product_category = ProductCategory.find_by_product_id(@product.id)
        @product_category.destroy
        @product.destroy
        respond_to do |format|
            format.html { redirect_to root_path, notice: "Product was successfully destroyed." }
        end
    end

    private
    def set_product
        @product = Product.friendly.find(params[:id])
    end

    
    def product_params
        params.require(:product).permit(:title, :description, :price, :stock, category_ids: [])
    end
    
end
