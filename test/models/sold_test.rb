require 'test_helper'

class SoldTest < ActiveSupport::TestCase

  setup do
    @vendido = solds(:one)
  end

  test "el precio debe ser un numero" do #REVISAR
    @vendido.price = 'lala'
    assert @vendido.save
  end

  test "prueba" do #PRUEBA DE COMPARACION 
  	assert @vendido.item == Item.first
  end

end
