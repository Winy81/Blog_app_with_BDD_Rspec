module ArticlesHelper
  #ansure the comments can come just from database
  def presisted_comments(comments)
  	comments.reject{ |comment| comment.new_record? }
  end

end
