class Holding < ApplicationRecord
  belongs_to :user

  validates :stock_name, presence: true
  validates :total_shares_owned, numericality: { greater_than_or_equal_to: 0 }
  validates :average_buy_price, numericality: { greater_than_or_equal_to: 0 }
  validates :total_value, numericality: { greater_than_or_equal_to: 0 }
end
