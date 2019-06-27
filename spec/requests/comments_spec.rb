require 'rails_helper'

RSpec.describe "Comments", type: :request do 

	before do
		@john = User.create(email: "john@test.com", password: "password")
		@jane = User.create(email: "jane@test.com", password: "password")
		@article = Article.create!(title: "Title one", body: "Body of article one", user: @john)
	end

	describe 'POST /articles/:id/comments' do 
		context 'with a non-signed in user' do
		  before do
			post "/articles/#{@article.id}/comments", params: { comment: {body: "Awesome blog."} } 
		  end

		  it "redirects user to the signin page" do 
			flash_message = "Please sign in or sign up first"
			expect(response).to redirect_to(new_user_session_path) 
			expect(response.status).to eq 302 
			expect(flash[:alert]).to eq flash_message
		  end
		end

		context 'with a logged in user' do 
		  before do
			login_as(@jane)
  			post "/articles/#{@article.id}/comments", params: { comment: {body: "Awesome blog."} }
  		  end

		  it "creates the comment successfully" do 
			 flash_message = "Comment has been created"
			 expect(response).to redirect_to(article_path(@article)) 
			 expect(response.status).to eq 302 
			 expect(flash[:notice]).to eq flash_message
		  end
		end
	end

	describe 'DELETE /articles/:id/comments' do
		context 'delete comment by owner' do
		  before do
			login_as(@jane)
			@comment = @article.comments.create!(body: "test comment", user: @john)	 
		  end

		  it "deletes the comment successfully" do
		  	delete "/articles/#{@article.id}/comments/#{@comment.id}"
			flash_message = "Comment has been deleted"
			expect(response.status).to eq 204 
			expect(flash[:notice]).to eq flash_message
		  end
		end
	end 

end