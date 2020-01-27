require 'test_helper'

class SellTest < ActiveSupport::TestCase
    
  setup do
    @venta1 = sells(:one)
    @venta2 = sells(:two)
    @venta3 = sells(:three)
  end

  test "La venta tiene todos los atributos" do #REVISAR
    assert_not Sell.new.valid?
  end

  # test "has all valid attributes" do
  #   s = Sell.new
  #   assert_not s.valid?
  #   # [:user, :client, :items].each do | field |
  #   #   assert_includes s.errors.details[field], error: :blank
  #   # end
  #   s.user= users(:one)
  #   s.client= clients(:one)
  #   products(:one).sell(1, s)
  #   assert s.valid?
  # end

  # test "price is correct" do
  #   s = Sell.new(user: users(:one), client: clients(:one))
  #   products(:one).sell(2, s)
  #   assert_equal products(:one).price*2, s.price
  # end


end
