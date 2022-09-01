class OrdersController < ApplicationController
    before_action :set_order, only: [:show, :update]
    before_action :authorize_admin, only: [:update, :delete]
    

    def index
        if @current_user.admin
            orders = Order.all
            render json: orders, include: ['products'], status: :ok  
        else
            orders = @current_user.orders
            render json: orders, include:['products'], status: :ok
             
        end
    end

    def show
        render json: @order, include: ['products'], status: :ok
    end
    

    def create 
        @order = @current_user.orders.create(product_params)
        render json: @order, status: :created
    end

    def update 
        unless @order.update(order_params)
            render json: {errors: @user.errors.full_messages},
            status: :unprocessable_entity
        end
    end

        
    private
    def product_params
        params.permit(product_ids: [])
    end

    def authorize_admin
        return unless !@current_user.admin?
        render json: {error: 'Admins only'}
    end

    def set_order
        @order = @current_user.orders.find(params[:id])
    end
    
    def order_params
        params.permit(:fulfilled)
    end


end
