require "rails_helper"

RSpec.feature "Showing an Article" do

	before do 
		@article = Article.create(title: "The first article",
		body: "Lorem ipsum dolor sit amet, consectetur.") 
	end

	scenario "A user shows an article" do 
		visit "/"
		click_link @article.title

		expect(page).to have_content(@article.title)
		expect(page).to have_content(@article.body)
		expect(page).to have_content(@article.created_at.strftime("%b %d %Y"))
		expect(page.current_path).to eq(article_path(@article))
	end

end