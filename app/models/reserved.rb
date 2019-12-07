class Reserved < ApplicationRecord
  belongs_to :reservation
  belongs_to :product
  belongs_to :item

  def self.reservationsNoSale
    @connection = ActiveRecord::Base.connection
    result = @connection.exec_query("SELECT * FROM reservations r WHERE r.status=Pendiente")
    return result
  end

  def self.reservationsId(code)
    @connection = ActiveRecord::Base.connection
    result = @connection.exec_query("SELECT * FROM reservations r WHERE r='#{code}'")
    return result
  end

end
