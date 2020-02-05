require 'test_helper'

class SellTest < ActiveSupport::TestCase
    
  test "el cliente no puede estar en blanco" do 
	a = Sell.create(user_id: 1)
  	assert_not a.save
  end

  test "el cliente debe existit" do
  	a = Sell.create(client_id:99999)
  	assert_not a.save
  end

  test "el usuario no puede estar en blanco" do
  	a = Sell.create(client_id: 1)
  	assert_not a.save
  end

  test "el usuario debe existir" do
  	a = Sell.create(user_id: 9999)
  	assert_not a.save 
  end

  test "la reserva no puede estar en blaco" do
  	a = Sell.create(client_id:1,user_id:1)
  	assert_not a.save
  end

  test "la reserva debe existir" do
  	a = Sell.create(reservation_id:99999) 
	assert_not a.save
  end

  test "la venta es correcta" do
  	assert_equal(true, Sell.create(client_id:1, user_id:1, reservation_id:1))
  end

end
