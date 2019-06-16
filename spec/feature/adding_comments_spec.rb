require 'rails_helper'

RSpec.feature "Adding reviews to Article" do
	before do
		@john = User.create(email: "john@test.com", password: "password")
		@jane = User.create(email: "jane@test.com", password: "password")
		@article = Article.create!(title: "Title one", body: "Body of article one", user: @john)
	end

	scenario "permits a signed in user to write a review" do
		login_as(@jane)

		visit "/"

		click_link @article.title
		fill_in "New Comment", with: "An awesome article" 
		click_button "Add Comment"
		expect(page).to have_content("Comment has been created") 
		expect(page).to have_content("An awesome article") 
		expect(current_path).to eq(article_path(@article))
	end 
end