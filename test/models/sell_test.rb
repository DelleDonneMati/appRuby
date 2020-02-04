require 'test_helper'

class SellTest < ActiveSupport::TestCase
    
  test "el cliente no puede estar en blanco" do
  	assert_equal(["el campo cliente no puede estar en blaco"], 
	Sell.create(user_id: 1).errors.full_messages)
  end

  test "el cliente debe existit" do
  	assert_equal(["debe ser un cliente existente"], 
	Sell.create(client_id: 99999).errors.full_messages)
  end

  test "el usuario no puede estar en blanco" do
  	assert_equal(["el campo usuario no puede estar en blanco"], 
	Sell.create(client_id: 1).errors.full_messages)
  end

  test "el usuario debe existir" do
  	assert_equal(["debe ser un usario existente"], 
	Sell.create(user_id: 9999).errors.full_messages)
  end

  test "la reserva no puede estar en blaco" do
  	assert_equal(["debe ser una reserva existente"], 
	Sell.create(reservation_id: 9999).errors.full_messages)
  end

  test "la reserva debe existir" do
  	assert_equal(["debe ser una reserva existente"], 
	Sell.create(user_id: 9999).errors.full_messages)
  end

  test "la venta es correcta" do
  	assert_equal(true, Sell.create(client_id:1, user_id:1, reservation_id:1))
  end

end
