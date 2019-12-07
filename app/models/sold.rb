class Sold < ApplicationRecord
  belongs_to :sell
  belongs_to :product
  belongs_to :item
end
