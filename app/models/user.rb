class User < ApplicationRecord
    def self.login(u,p)
        @connection = ActiveRecord::Base.connection
  	    result = @connection.exec_query("SELECT * FROM users WHERE username='#{u}'")
  	    return result
    end
end
