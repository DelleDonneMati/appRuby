require 'test_helper'

class ProductTest < ActiveSupport::TestCase
  
  setup do
    @producto = products(:one)
  end

  test "no debe guardar un producto sin un codigo" do 
    @producto.unicode = nil
    assert_not @producto.save
  end

  test "no debe guardar un producto sin un descripcion" do 
    @producto.descrip = nil
    assert_not @producto.save
  end

  test "no debe guardar un producto sin un detalle" do 
    @producto.detail = nil
    assert_not @producto.save
  end

  test "no debe guardar un producto sin un precio" do 
    @producto.price = nil
    assert_not @producto.save
  end

  test "la descripcion debe ser un string" do 
    @producto.descrip = "100"
    assert_not @producto.save
  end

  test "el detalle debe ser un string" do 
    @producto.detail = "100"
    assert_not @producto.save
  end

  test "el precio debe ser un numero" do 
    @producto.price = 'lala'
    assert_not @producto.save
  end

  test "codigo unico" do 
    Product.new(unicode: '123ABCDEF', descrip:'', detail:'', price: 0, name:'').save
    assert_not Product.new(unicode: '123ABCDEF', descrip:'', detail:'', price: 0, name:'').valid?, "El Codigo se repite"
  end

  test "descripción con menos de 200 caracteres" do 
    description = [*('a'..'z')].shuffle[0, 210].join
    assert_not Product.new(unicode: '123ABCDEF', descrip: description, detail:'', price: 0).valid?, "La descripcion es muy larga"
  end

  test "el codigo tiene menos de 9 caracteres " do
    assert_not Product.new(unicode:"12ABC", descrip:"lala", detail: "lala", price: 45).valid?, "El codigo debe tener 9 caracteres"
  end

  test "el producto tiene todos los atributos" do 
    assert_not Product.new.valid?
    assert_not Product.new(unicode: '123ABCDEF').valid?
    assert_not Product.new(unicode: '123ABCDEF', descrip:'').valid?
    assert_not Product.new(unicode: '123ABCDEF', descrip:'', detail: '').valid?
    assert_not Product.new(unicode: '123ABCDEF', descrip:'', detail: '', price: 0,name:'').valid?
  end

  test "in_stock esta bien" do 
    assert_not Product.get_in_stock.include? Product.find_by(unicode: '123ABCDEF')
  end

  test "scarce esta bien" do 
    assert_not Product.get_scarce.include? Product.find_by(unicode: '123ABCDEF')
  end
end
