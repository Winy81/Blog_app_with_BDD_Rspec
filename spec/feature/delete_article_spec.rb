require 'rails_helper'

RSpec.feature "Deleting an article" do 

	before do 
		@article = Article.create(title: "Title one", body: "Body of article one")
	end

	scenario "User deletes an article" do 
		visit "/"

		click_link @article.title
		click_link "Delete Article"

		expect(page).to have_content("Article has been deleted")
		expect(current_path).to eq(article_path)
	end

end