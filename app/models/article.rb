class Article < ApplicationRecord
	validates_presence_of :title, message: "Title can't be blank"
	validates_presence_of :body, message: "Body can't be blank"
end
