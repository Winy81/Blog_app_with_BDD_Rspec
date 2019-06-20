require 'rails_helper'

RSpec.describe "Articles", type: :request do 

	before do
		@john = User.create(email: "john@test.com", password: "password")
		@jane = User.create(email: "jane@test.com", password: "password")
		@article = Article.create!(title: "Title one", body: "Body of article one", user: @john)
	end

end