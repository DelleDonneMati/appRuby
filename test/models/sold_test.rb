require 'test_helper'

class SoldTest < ActiveSupport::TestCase

  setup do
    @vendido = solds(:one)
  end

  test "el precio debe ser un numero" do
    @vendido.price = 'lala'
    assert @vendido.save
  end

end
