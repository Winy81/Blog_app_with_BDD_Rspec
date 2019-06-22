class CommentsController < ApplicationController

	before_action :set_article

	def create
	  unless signed_in?
	  	flash[:alert] = "Please sign in or sign up first"
	  	redirect_to new_user_session_path
	  else
		@comment = @article.comments.new(comment_params)
		@comment.user = current_user
		  if @comment.save
		  	ActionCable.server.boradcast "comments",
		  	  render(partial: 'comments/comment', object: @comment)
		    flash[:notice] = "Comment has been created"
		    redirect_to article_path(@article)
		  else
		  	flash.now[:alert] = "Comment hasn't been created"
		  	redirect_to article_path(@article)
		  end
	  end
	end

	private
	  def comment_params
	  	params.require(:comment).permit(:body)
	  end

	  def set_article
	  	@article = Article.find(params[:article_id])
	  end
end
