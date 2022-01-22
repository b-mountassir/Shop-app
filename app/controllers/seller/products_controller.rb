class Seller::ProductsController < ApplicationController
    before_action :authenticate_user!, only: [:new, :create, :edit, :destroy, :update] ## require user to login 
    before_action :set_product, only: [:show, :edit, :update, :destroy ]
    def new
        @product = Product.new
        authorize @product
    end

    def edit
        authorize @product
    end

    def create
        authorize @product
        @product = Product.new(product_params)
        @product.seller = current_user
        respond_to do |format|
            if @product.save
                format.html { redirect_to edit_seller_product_path(@product), notice: "Product was successfully created." }
            else
                format.html { render :new, status: :unprocessable_entity }
            end
        end
    end

    def update
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
        @product.destroy
        respond_to do |format|
            format.html { redirect_to products_url, notice: "Product was successfully destroyed." }
        end
    end

    private
    def set_product
        @product = Product.friendly.find(params[:id])
    end

    
    def product_params
        params.require(:product).permit(:title, :description, :price, :stock)
    end
    
end
