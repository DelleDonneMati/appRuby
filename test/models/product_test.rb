require 'test_helper'

class ProductTest < ActiveSupport::TestCase

  test "codigo unico" do
    assert Product.new(unicode: 'ABC123478', descrip:'', detail:'', price: 0, name:'').save
    assert_not Product.new(unicode: 'ABC123478', descrip:'', detail:'', price: 0, name:'').valid?, "El Codigo se repite"
  end

  test "Descripción con menos de 200 caracteres" do
    description = [*('a'..'z')].shuffle[0, 210].join
    assert_not Product.new(unicode: 'ABC234567', descrip: description, detail:'', price: 0).valid?, "La descripcion es muy larga"
    description = [*('a'..'z')].shuffle[0, 200].join
    assert Product.new(unicode: 'ABC234567', descrip: description, detail:'', price: 0).valid?, "La descripcion es muy corta"
  end

  test "El codigo es valido" do
    assert Product.new(unicode: 'BCD123456', descrip:'', detail:'', price: 0, name:'').valid?
    assert_not Product.new(unicode: 'BCD1234567', descrip:'', detail:'', price: 0, name:'').valid?
    assert_not Product.new(unicode: 'BC2347', descrip:'', detail:'', price: 0, name:'').valid?
  end

  test "El producto tiene todos los atributos" do
    assert_not Product.new.valid?
    assert_not Product.new(unicode: 'ABC123456').valid?
    assert_not Product.new(unicode: 'ABC123456', descrip:'').valid?
    assert_not Product.new(unicode: 'ABC123456', descrip:'', detail: '').valid?
    assert Product.new(unicode: 'ABC123456', descrip:'', detail: '', price: 0,name:'').valid?
  end

  test "stock esta bien" do
    assert_equal Product.find_by(unicode: 'QWE123456').stock, 6
    assert_equal Product.find_by(unicode: 'QWE123457').stock, 5
  end

  test "in_stock esta bien" do
    assert_not Product.getInStock.include? Product.find_by(unicode: 'QWE123456')
    assert_not Product.getInStock.include? Product.find_by(unicode: 'QWE123457')
    assert Product.getInStock.include? Product.find_by(unicode: 'QWE123458')
  end

  test "scarce esta bien" do
    assert Product.getScarce.include? Product.find_by(unicode: 'QWE123456')
    assert_not Product.getScarce.include? Product.find_by(unicode: 'QWE123457')
    assert_not Product.getScarce.include? Product.find_by(unicode: 'QWE123458')
  end


end
