class Phone < ApplicationRecord
  belongs_to :client

  validates :number, presence: true, null: false
end
