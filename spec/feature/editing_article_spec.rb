require 'rails_helper'

RSpec.feature "Editing an article" do 

	before do
		john = User.create(email: "john@test.com", password: "password")
		login_as(john) 
		@article = Article.create(title: "Title one", body: "Body of article one", user: john)
	end

	scenario "A user updates an article" do 
		visit "/" #root path

		click_link @article.title
		click_link "Edit Article"
		fill_in "Title", with: "Updated Title"
		fill_in "Body", with: "Updated Body io Article"
		click_button "Update Article"
		expect(page).to have_content("Article has been updated")
		expect(current_path).to eq(article_path(@article)) 
	end

	scenario "A user fails updates an article" do 
		visit "/" #root path

		click_link @article.title
		click_link "Edit Article"
		fill_in "Title", with: ""
		fill_in "Body", with: "Updated Body io Article"
		click_button "Update Article"
		expect(page).to have_content("Article has not been updated")
		expect(current_path).to eq(article_path(@article)) 
	end

end



