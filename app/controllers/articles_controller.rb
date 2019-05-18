class ArticlesController < ApplicationController
  #before_action :authenticate_user!, except: [:index, :show]
  before_action :set_article, only:[:show,:edit,:update,:destroy] #filtering @article = Article.find(params[:id]) line of code what is includeed, :show,:edit,:update,:destroy action. We can setup a method for them to keep the code DRY

  def index
  	@articles = Article.all
  end

  def new
  	@article = Article.new
  end

  def create
  	@article = Article.new(article_params)
  	if @article.save
  	   flash[:success] = "Article has been created"
  	   redirect_to articles_path
  	else
  	   flash.now[:danger] = "Article has not been created"	
  	   render :new
  	end
  end

  def show
  	#@article = Article.find(params[:id]) setup as before action with set article method
  end

  def edit
  	#@article = Article.find(params[:id]) setup as before action with set article method
  end

  def update 
  	#@article = Article.find(params[:id]) setup as before action with set article method
  	if @article.update(article_params)
  		flash[:success] = "Article has been updated"
  		redirect_to article_path(@article)
  	else
  		flash.now[:danger] = "Article has not been updated"
  		render :edit #or edit_path
  	end
  end

  def destroy
	#@article = Article.find(params[:id]) setup as before action with set article method
	if @article.destroy
		flash[:success] = "Article has been deleted."
		redirect_to articles_path
	end
  end

  protected

  def resources_not_found
  	message = "The article couldn't be found"
  	flash[:alert] = message
  	redirect_to root_path
  end

  private

  def set_article
  	@article = Article.find(params[:id])
  end

  def article_params
  	params.require(:article).permit(:title,:body)
  end

end
