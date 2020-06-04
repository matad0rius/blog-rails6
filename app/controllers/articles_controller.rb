class ArticlesController < ApplicationController
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]

    def show 
        # @article = Article.find(params[:id]) 
    end 

    def index
         @articles = Article.paginate(page: params[:page], per_page: 8)
    end

    def new
        @article = Article.new
    end

    def edit
        # @article = Article.find(params[:id]) 
    end

    def create
        @article = Article.new(article_params)
        @article.user = current_user
        # @article = Article.new(params.require(:article).permit(:title, :description))
        if @article.save
            flash[:notice] = "Article was created succesfully."
            redirect_to @article
        else
            render 'new'
        end
    end

    def update
        # @article = Article.find(params[:id])
        if @article.update(article_params)
        # if @article.update(params.require(:article).permit(:title, :description))
            flash[:notice] = "Article was created sucessfully"
            redirect_to @article
        else
            render 'edit'
        end
    end

    def destroy
        # @article = Article.find(params[:id])
        @article.destroy
        redirect_to articles_path
    end

    private

    def set_article
        @article = Article.find(params[:id])
    end

    def article_params
        params.require(:article).permit(:title, :description)
    end

    def require_same_user
        if current_user != @article.user
            flash[:alert] = "Ypu can only edit or delete your own article"
            redirect_to @article
    end

end