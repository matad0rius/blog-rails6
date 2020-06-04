class UsersController < ApplicationController
    before_action :set_user, only: [:show, :edit, :update, :destroy]
    before_ation :require_user, only: [:edit, :update]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def show
        @articles = @user.articles.paginate(page: params[:page], per_page: 4)
    end

    def index
        @users = User.paginate(page: params[:page], per_page: 4)
    end
    
    def new
        @user = User.new
    end

    def edit
    end

    def update 
        if @user.update(user_params)
            flash[:notice] = "Your acc info was updated"
        redirect_to @user
        else
            render 'edit'
        end
    end 
    
    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id
            flash[:notie] = "Welcome you have SignUp #{@user.username} "
            redirect_to articles_path
        else
            render 'new'
        end
    end

    def destroy
        @user.destroy
        session[:user_id] = nil
        flash[:notice] = "Acc and all articles deleted"
        redirect_to articles_path
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password)
    end

    private

    def set_user
        @user = User.find(params[:id])
    end

    def require_same_user
        if current_user != @user
            flash[:alert] = "You can only edit your own acc"
            redirect_to @user
        end
    end

end