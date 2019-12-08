class Reserved < ApplicationRecord
  belongs_to :reservation
  belongs_to :item

  def self.giveMeItems(id)
  @connection = ActiveRecord::Base.connection
	result = @connection.exec_query("SELECT *
      FROM reservations r INNER JOIN reserveds r2 ON r.id = r2.reservations_id
      WHERE r.id = '#{id}'")
	return result
  end
end
