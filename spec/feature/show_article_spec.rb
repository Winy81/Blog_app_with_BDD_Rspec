require "rails_helper"

RSpec.feature "Showing an Article" do

	before do
		@john = User.create(email: "john@test.com", password: "password")
		@jane = User.create(email: "jane@test.com", password: "password")
 		@article = Article.create(title: "The first article",
		body: "Lorem ipsum dolor sit amet, consectetur.", user: @john) 
	end

	scenario "for non-sigend in user hide the Edit end Delete buttons" do 
		visit "/"
		click_link @article.title

		expect(page).to have_content(@article.title)
		expect(page).to have_content(@article.body)
		expect(page).to have_content(@article.created_at.strftime("%b %d %Y"))
		expect(page.current_path).to eq(article_path(@article))

		expect(page).not_to have_link("Eit Article")
		expect(page).not_to have_link("Delete Article")
	end

	scenario "for non-owner user hide the Edit end Delete buttons" do 
		login_as(@jane)
		visit "/"
		click_link @article.title

		expect(page).to have_content(@article.title)
		expect(page).to have_content(@article.body)
		expect(page).to have_content(@article.created_at.strftime("%b %d %Y"))
		expect(page.current_path).to eq(article_path(@article))

		expect(page).not_to have_link("Edit Article")
		expect(page).not_to have_link("Delete Article")
	end

	scenario "for owner user sees both the Edit end Delete buttons" do 
		login_as(@john)
		visit "/"
		click_link @article.title

		expect(page).to have_content(@article.title)
		expect(page).to have_content(@article.body)
		expect(page).to have_content(@article.created_at.strftime("%b %d %Y"))
		expect(page.current_path).to eq(article_path(@article))

		expect(page).to have_link("Edit Article")
		expect(page).to have_link("Delete Article")
	end

end