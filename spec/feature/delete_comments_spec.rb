require 'rails_helper'

RSpec.feature "Delete comment" do
	before do
		@john = User.create(email: "john@test.com", password: "password")
		@jane = User.create(email: "jane@test.com", password: "password")
		@article = Article.create!(title: "Title one", body: "Body of article one", user: @john)
		@comment_1 = @article.comments.create(body: "first comment")
		@comment_2 = @article.comments.create(body: "sec comment")
	end
end