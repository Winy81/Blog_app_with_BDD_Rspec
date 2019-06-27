require 'rails_helper'

RSpec.feature "Delete comment" do
	before do
		@john = User.create(email: "john@test.com", password: "password")
		@jane = User.create(email: "jane@test.com", password: "password")
		@article = Article.create!(title: "Title one", body: "Body of article one", user: @john)
		@comment_1 = @article.comments.create!(body: "first comment", user: @jane)	
	end

	scenario "user delete her own comment" do
		login_as(@jane)

		visit "/"

		click_link @article.title

		@comment_2 = @article.comments.create!(body: "second comment", user: @john)	

		click_on("Remove Comment",match: :first)
		expect(page).not_to have_content(@comment_1.body)
		expect(page).to have_content(@comment_2.body)
		expect(current_path).to eq(article_path(@article))
	end

	scenario "user cant delete other user's comment" do
		login_as(@jane)

		visit "/"

		click_link @article.title

		@comment_2 = @article.comments.create!(body: "second comment", user: @john)	

		click_on("Remove Comment",match: :first)
		expect(page).not_to have_content(@comment_1.body)
		expect(page).to have_content(@comment_2.body)
		expect(page).not_to have_button("Remove Comment")
		expect(current_path).to eq(article_path(@article))
	end

end