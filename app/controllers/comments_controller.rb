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
		  	ActionCable.server.broadcast "comments",
		  	  render_to_string(partial: 'comments/comment', object: @comment)
		    flash[:notice] = "Comment has been created"
		  else
		  	flash.now[:alert] = "Comment hasn't been created"
		  end
		  redirect_to article_path(@article)
	  end
	end

	def destroy
	  unless signed_in?
	  	flash[:alert] = "Please sign in or sign up first"
	  	redirect_to new_user_session_path
	  else		
	    @comment = @article.comments.find(params[:id])
	      if @comment.user.id == current_user.id
	  	    @comment.destroy
	  	    flash[:notice] = "Comment has been deleted"
	  	  else
	  	  	flash[:alert] = "You have permition to delete just your own comment"
	      end
	      redirect_to article_path(@article)
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
