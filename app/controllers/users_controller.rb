class UsersController < ApplicationController
    skip_before_action :authenticate_request, only: [:create]
    before_action :set_user, only: [:show, :destroy]
    before_action :authorize_admin, only: [:index]

    # GET /users
    
    def index
        @users = User.all
        render json: @users, status: :ok
    end

    # GET /users/{username}
    
    def show 
        render json: @user, status: :ok
    end

    # POST /users
    
    def create
        @user = User.new(user_params)
        if @user.save
            render json: @user, status: :created
       else
        render json: { erros: @user.errors.full_messages },
                status: :unprocessable_entity
       end
    end
    
    # PUT /users/{username}
    def update
        unless @user.update(user_params)
            render json: {errors: @user.errors.full_messages},
            status: :unprocessable_entity
        end
    end

    #DELETE /users/{username}
    def destroy 
        @user.destroy
    end

    private 
        def user_params
            params.permit(:username, :email, :password, :name)
        end
        def set_user
            @user = User.find(params[:id])
        end
        def authorize_admin
            return unless !@current_user.admin?
            render json: {error: 'Admins only'}
        end


end
