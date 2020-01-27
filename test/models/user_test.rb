require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "username is unique, password is present" do
    u = User.new
    assert u.valid?
    # assert_includes u.errors.details[:username], error: :blank
    # assert_includes u.errors.details[:password], error: :blank
    u.username= users(:one).username
    assert u.valid?
    # assert_includes u.errors.details[:username], { error: :taken, value: u.username }
    u.password= "aaa"
    u.username= "aaa"
    assert u.valid?
  end

end
