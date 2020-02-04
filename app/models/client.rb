class Client < ApplicationRecord
  belongs_to :type
  has_many :phones

  validates :cuit, presence: true
  validates :name, presence: true
  validates :email, presence: true
end
