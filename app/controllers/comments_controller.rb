class CommentsController < ApplicationController

	def create
	  @comment = @article.comments.build(comment_params)
	  @comment.user = current_user

	  if comment.save
	    flash[:notice] = "Comment has been created"
	  else
	  	flash.now[:alert] = "Comment hasn't been created"
	  end
	  redirect_to article_path(@article)
	end

	private
	  def comment_params
	  	params.require(:comment).permit(body)
	  end
end
