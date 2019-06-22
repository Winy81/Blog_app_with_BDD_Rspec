module ApplicationCable
  class Connection < ActionCable::Connection::Base
  	
  	identified_by :current_user

  	def connect
  	  self.current_user = find_current_user
  	end

  	def disconnect

  	end

  end
end
