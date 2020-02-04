require 'test_helper'

class PhoneTest < ActiveSupport::TestCase
  test "el numero esta en blanco" do
  	assert_equal(["El numero de telefono esta en blanco"],
  	Phone.create(client_id:1).errors.full_messages)
  end
  
  test "el cliente esta en blanco" do
  	assert_equal(["El campo cliente esta en blanco"],
	Phone.create(number:4523891).errors.full_messages)
  end
  
  test "el cliente no existe" do
  	assert_equal(["El cliente no existe"],
  	Phone.create(client_id:999999).errors.full_messages)
  end
  
  test "hay cliente y numero de telefono" do
  	assert(true,Phone.create(number:4523891, client_id:1).valid?)
  end

end
