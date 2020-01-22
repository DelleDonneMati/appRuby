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

end
