require 'rails_helper'

RSpec.describe ArticlesController, type: :controller do

  describe "GET #index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "Create new Article" do
  	it "should be passed with dedicated fields" do
  		@article = Article.create(title:"test",body:"test")
  		expect(@article).to be_valid
  	end

  end

end
