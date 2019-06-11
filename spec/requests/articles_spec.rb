require 'rails_helper'

RSpec.describe "Articles", type: :request do 

	before do
		@john = User.create(email: "john@test.com", password: "password")
		@jane = User.create(email: "jane@test.com", password: "password")
		@article = Article.create!(title: "Title one", body: "Body of article one", user: @john)
	end


	describe 'GET /articles/:id' do 
		context 'with existing article' do 
			before { get "/articles/#{@article.id}"}

			it " has handle existing article" do 
				expect(response.status).to eq(200)
			end
		end

		context 'with non-existing article' do 
			before { get "/articles/radnom_not_exist"}

			it 'has handle non-existing article' do 
				expect(response.status).to eq(302)
				flash_message = "The article couldn't be found"
				expect(flash[:alert]).to eq(flash_message)
			end
		end
	end
end