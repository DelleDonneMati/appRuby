class Item < ApplicationRecord
  belongs_to :product
  belongs_to :saleable, polymorphic: true, optional: true

  validates :product, presence: true
  validates_associated :product, :saleable

  def is_in_stock
    saleable.nil?
  end

  def is_reserved
    (! is_in_stock) && (saleable.is_a? Reservation)
  end

  def is_sold
    (! is_in_stock) && (! is_reserved)
  end

  def state
    if is_in_stock
      'disponible'
    elsif is_reserved
      'reservado'
    else
      'vendido'
    end
  end

  def price
    if is_sold
      self[:price]
    else
      product.price
    end
  end
end
