class Seller::ProductsController < Seller::BaseController
    before_action :authenticate_user! ## require user to login 
    before_action :set_product, only: [:show, :edit, :update, :destroy ]
    
    def show
        set_product
    end
    
    
    def new
        @product = Product.new
        authorize @product
    end

    def edit
        @product
        
        @category = @product.categories.first

    end

    def create
       
        @product = Product.new(product_params)
        @product.product_picture.attach(product_params[:product_picture])
        @product.seller = current_user
        authorize @product
        respond_to do |format|
            if @product.save
                format.html { redirect_to(request.referrer || seller_product_path(@product)) }
                flash[:notice] = "Product was successfully created." 
            else
                format.html { render :new, status: :unprocessable_entity }
            end
        end
    end

    def update
        
        respond_to do |format|
            if @product.update(ActiveModel::Type::Boolean.new.cast(product_params[:published]) ? product_params : product_params.merge(on_sale: false))
                format.html { redirect_to(request.referrer || seller_product_path(@product)) }
                flash[:notice] = "Product was successfully updated." 
            else
                format.html { render :edit, status: :unprocessable_entity }
            end
        end
    end

    def destroy
        @product
        if @product.soft_destroy
             redirect_to seller_dashboard_path, notice: "Product was successfully destroyed."  
        else
            redirect_to @product, flash: { error: "Product could not be deleted" }
        end
    end

    private
    def set_product
        @product = authorize Product.friendly.find(params[:id])
        @category = @product.categories.first
    end

    
    def product_params
        if defined?(@product.published)
            unless @product.published?
                params.require(:product).permit(:title, :description, :price, :stock,
                :product_picture, :published, :on_sale, category_ids: [])
            else            
                params.require(:product).permit(:stock, :published, :on_sale)
            end
        else
            params.require(:product).permit(:title, :description, :price, :stock,
                :product_picture, :published, :on_sale, category_ids: [])
        end
    end
    
end
