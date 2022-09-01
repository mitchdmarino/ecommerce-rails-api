class OrdersController < ApplicationController
    before_action :set_order, only: [:show, :update, :addProduct]

    def index 
        orders = @current_user.orders
        render json: orders, status: :ok
    end

    def show
        products = @order.products
        render json: {
            order: @order,
            products: products
        }, status: :ok
    end
    
    def create 
        @order = @current_user.orders.create(product_params)
        render json: @order, status: :created
    end

        
    private
    def product_params
        params.permit(product_ids: [])
    end


    def set_order
        @order = @current_user.orders.find(params[:id])
    end


end
