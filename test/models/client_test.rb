require 'test_helper'

class ClientTest < ActiveSupport::TestCase
  
  test "client has all attributes" do
    c = Client.new()
   	assert_not c.valid?
    c = Client.new(name: 'a', email: 'a@mail.com', type_id: types(:one), cuit: '11111')
    assert_not c.valid?
  end

  test "email is valid" do
    c = Client.new(email: 'amail.com')
    c.valid?
    # assert_includes c.errors.details[:email], {error: :invalid, value: 'amail.com'}
    c.email = 'a@mail.com'
    c.valid?
    assert_empty c.errors.details[:email]
  end

end
