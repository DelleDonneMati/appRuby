require 'test_helper'

class UserTest < ActiveSupport::TestCase

  test "el campo username no puede estar en blanco" do
    assert_equal(["el campo username no puede estar en blaco"], 
    User.create(password:1231).errors.full_messages)
  end

  test "el campo password no puede estar en blanco" do
    assert_equal(["el campo password no puede estar en blaco"], 
    User.create(username:"Matias").errors.full_messages)
  end

  test "usurio correcto" do
    assert_equal(true, User.create(username:"Matias",password:123232).valid?)
  end


end
