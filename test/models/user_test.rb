require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "el campo username no puede estar en blanco" do
    a = User.create(username: nil,password:123123)
    assert_not a.save
  end

  test "el campo password no puede estar en blanco" do
    a = User.create(username: "Jose", password: nil)
    assert_not a.save
  end

  test "usurio correcto" do
    assert_equal(true, User.create(username:"Pato",password:123232).valid?)
  end


end
