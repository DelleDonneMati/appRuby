require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "product is valid" do
    i = Item.new
    i.valid?
    assert_includes i.errors.details[:product], error: :blank
    i.product = Product.new
    i.valid?
    assert_includes i.errors.details[:product], { error: :invalid, value: i.product }
    i.product = products(:one)
    i.valid?
    assert_empty i.errors.details[:product]
  end

end
