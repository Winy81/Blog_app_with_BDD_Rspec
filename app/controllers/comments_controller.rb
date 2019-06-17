class CommentsController < ApplicationController

	def create
	  @comment = @article.comments.new
	  @comment.user = current_user

	  if comment.save
	    flash[:notice] = "Comment has been created"
	  else
	  	flash.now[:alert] = "Comment hasn't been created"
	  end
	  redirect_to article_path(@article)
	end

end
