class ProductsController < ApplicationController
    skip_before_action :authenticate_request, only: [:index, :show]
    before_action :authorize_admin, only: [:update, :destroy, :create]
    before_action :set_product, only: [:show, :destroy, :update]

    def index 
        @products = Product.all
        render json: @products, status: :ok
    end
    
    def show
        render json: @product, status: :ok
    end

    def create 
        @product = Product.new(product_params)
        if @product.save
            render json: @product, status: :created
        else
            render json: {erros: @product.errors.full_messages},
            status: :unprocessable_entity
        
        end
    end

    def update 
        unless @product.update(product_params)
            render json: {errors: @user.erros.full_messages},
            status: :unprocessable_entity
        end
    end

    def destroy
        @product.destroy
        render json: {msg: "product deleted"}, status: :ok
    end
    
    
    private
    def authorize_admin
        return unless !@current_user.admin?
        render json: {error: 'Admins only'}
    end
    def product_params 
        params.permit(:name, :price, :description)
    end
    def set_product
        @product = Product.find(params[:id])
    end


end
