require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  
  setup do
    @producto = products(:one)
  end

  test "no debe guardar un producto sin un codigo" do #REVISAR
    @producto.unicode = nil
    assert_not @producto.save
  end

  test "no debe guardar un producto sin un descripcion" do #REVISAR
    @producto.descrip = nil
    assert_not @producto.save
  end

  test "no debe guardar un producto sin un detalle" do #REVISAR
    @producto.detail = nil
    assert_not @producto.save
  end

  test "no debe guardar un producto sin un precio" do #REVISAR
    @producto.price = nil
    assert_not @producto.save
  end

  test "la descripcion debe ser un string" do #REVISAR
    @producto.descrip = 100
    assert @producto.save
  end

  test "el detalle debe ser un string" do #REVISAR
    @producto.detail = 100
    assert @producto.save
  end

  test "el precio debe ser un numero" do #REVISAR
    @producto.price = 'lala'
    assert @producto.save
  end

  test "codigo unico" do #REVISAR
    Product.new(unicode: 'ABC123478', descrip:'', detail:'', price: 0, name:'').save
    assert_not Product.new(unicode: 'ABC123478', descrip:'', detail:'', price: 0, name:'').valid?, "El Codigo se repite"
  end

  test "descripción con menos de 200 caracteres" do #REVISAR
    description = [*('a'..'z')].shuffle[0, 210].join
    assert_not Product.new(unicode: 'ABC234567', descrip: description, detail:'', price: 0).valid?, "La descripcion es muy larga"
    # description = [*('a'..'z')].shuffle[0, 200].join
    # assert Product.new(unicode: 'ABC234567', descrip: description, detail:'', price: 0).valid?, "La descripcion es muy corta"
  end

  # test "El codigo es valido" do
  #   # assert Product.new(unicode: 'BCD123456', descrip:'', detail:'', price: 0, name:'').valid?
  #   assert_not Product.new(unicode: 'BCD1234567', descrip:'', detail:'', price: 0, name:'').valid?
  #   assert_not Product.new(unicode: 'BC2347', descrip:'', detail:'', price: 0, name:'').valid?
  # end

  test "el producto tiene todos los atributos" do #REVISAR
    assert_not Product.new.valid?
    assert_not Product.new(unicode: 'ABC123456').valid?
    assert_not Product.new(unicode: 'ABC123456', descrip:'').valid?
    assert_not Product.new(unicode: 'ABC123456', descrip:'', detail: '').valid?
    assert_not Product.new(unicode: 'ABC123456', descrip:'', detail: '', price: 0,name:'').valid?
  end

  # test "stock esta bien" do
  #   assert_equal Product.find_by(unicode: 'QWE123456').stock, 6
  #   assert_equal Product.find_by(unicode: 'QWE123457').stock, 5
  # end

  test "in_stock esta bien" do #REVISAR
    assert_not Product.get_in_stock.include? Product.find_by(unicode: 'ABC123')
    # assert_not Product.get_in_stock.include? Product.find_by(unicode: 'QWE123457')
    # assert Product.get_in_stock.include? Product.find_by(unicode: 'QWE123458')
  end

  test "scarce esta bien" do #REVISAR
    assert_not Product.get_scarce.include? Product.find_by(unicode: 'ABC123')
    # assert_not Product.get_scarce.include? Product.find_by(unicode: 'QWE123457')
    # assert_not Product.get_scarce.include? Product.find_by(unicode: 'QWE123458')
  end
end
