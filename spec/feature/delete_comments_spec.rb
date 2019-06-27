require 'rails_helper'

RSpec.feature "Delete comment" do
	before do
		@john = User.create(email: "john@test.com", password: "password")
		@jane = User.create(email: "jane@test.com", password: "password")
		@article = Article.create!(title: "Title one", body: "Body of article one", user: @john)
		@comment_1 = @article.comments.create(body: "first comment")
		@comment_2 = @article.comments.create(body: "sec comment")		
	end

	scenario "delete only last comment created by secondary user" do
		login_as(@jane)

		visit "/"

		@comment = @article.comments.last
		puts @comment

		click_link @article.title
		comment_jane_1 = @article.comments.create(body: "first comment by jane")
		comment_jane_2 = @article.comments.create(body: "sec comment by jane")
		click_button "Remove My Last Comment"
		expect(page).to have_content(@comment_1) 
		expect(page).to have_content(@comment_2)
		expect(page).to have_content(comment_jane_1)
		expect(page).not_to have_content(comment_jane_2)
		expect(current_path).to eq(article_path(@article))
	end

	scenario "delete only last comment created by primary user" do
		login_as(@john)

		visit "/"

		click_link @article.title
		click_button "Remove My Last Comment"
		expect(page).to have_content(@comment_1)
		expect(page).to have_content(@comment_2)
		expect(current_path).to eq(article_path(@article)) 
	end 
end