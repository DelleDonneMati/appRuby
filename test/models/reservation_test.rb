require 'test_helper'

class ReservationTest < ActiveSupport::TestCase

  setup do
    @reserva = reservations(:one)
  end

  test "no debe guardar una reserva sin un cliente" do
    @reserva.client = nil
    assert_not @reserva.save
  end

  test "no debe guardar una reserva sin un usuario" do
    @reserva.user = nil
    assert_not @reserva.save
  end

  


end
