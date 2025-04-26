class Holding < ApplicationRecord
  belongs_to :user

  validates :stock_name, presence: true
  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
  validates :average_price, numericality: { greater_than_or_equal_to: 0 }
end
