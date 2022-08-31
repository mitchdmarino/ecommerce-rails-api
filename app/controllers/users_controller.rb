class UsersController < ApplicationController
    skip_before_action :authenticate_request, only: [:create]
    before_action :set_user, only: [:show, :destroy]
    before_action :authorize_admin, only: [:index]

    # GET /users
    # only admin access
    def index
        @users = User.all
        render json: @users, status: :ok
    end

    # GET /users/{username}
    def show 
        render json: @current_user, status: :ok
    end

    # POST /users
    def create
        @user = User.new(user_params)
        if @user.save
            token = jwt_encode(user_id: @user.id, name: @user.name, email: @user.email, admin: @user.admin)
            render json: { token: token }, status: :created
       else
        render json: { erros: @user.errors.full_messages },
                status: :unprocessable_entity
       end
    end
    
    # PUT /users/{username}
    def update
        unless @current_user.update(user_params)
            render json: {errors: @user.errors.full_messages},
            status: :unprocessable_entity
        end
    end

    #DELETE /users/{username}
    def destroy 
        @current_user.destroy
        render json: {msg: 'User Deleted'},
        status: :ok
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
