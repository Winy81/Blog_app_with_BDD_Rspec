require 'rails_helper'

RSpec.describe "Articles", type: :request do 

	before do
		@john = User.create(email: "john@test.com", password: "password")
		@jane = User.create(email: "jane@test.com", password: "password")
		@article = Article.create!(title: "Title one", body: "Body of article one", user: @john)
	end

	describe 'GET /articles/:id/edit' do
		context 'with non-signed in user' do
		before { get "/articles/#{@article.id}/edit" }
			it "redirects to the signin page" do 
			expect(response.status).to eq 302
			flash_message = "You need to sign in or sign up before continuing."
			expect(flash[:alert]).to eq flash_message
			end 
		end

		context 'with signed in users who are non-owners' do 
			before do
				login_as(@jane)
				get "/articles/#{@article.id}/edit" 
			end
			it "redirects to the home page" do 
				expect(response.status).to eq 302
				flash_message = "You can only edit your own article." 
				expect(flash[:alert]).to eq flash_message
			end 
		end
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


	describe 'GET GET /articles/:id' do
		context 'with signed in users who are non-owners' do 
			before do
				login_as(@jane)
				delete "/articles/#{@article.id}" 
			end

			it 'redirects to the homepage' do
        		expect(response.status).to eq 302
        		flash_message = "You can only delete your own article!"
        		expect(flash[:danger]).to eq flash_message
      		end
		end

		context 'with signed in users who are owners' do 
			before do
				login_as(@john)
				delete "/articles/#{@article.id}" 
			end

			it 'successfully delete article' do
				expect(response.status).to eq 302
        		flash_message = "Article has been deleted."
        		expect(flash[:success]).to eq flash_message
			end
		end
	end
end