class Sell < ApplicationRecord
  belongs_to :client
  belongs_to :user
  belongs_to :reservation

  def self.giveMesale(reservation)
    @connection = ActiveRecord::Base.connection
  	result = @connection.exec_query("SELECT *
      FROM sells s LEFT JOIN reservations r ON r.sell_id = s.id
      WHERE r.id = '#{reservation}'")
  	return result[0]
  end

end
