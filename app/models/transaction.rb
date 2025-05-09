class Transaction < ApplicationRecord
  belongs_to :user

  validates :stock_name, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :stock_price_per_share, presence: true, numericality: true
  validates :total_price, presence: true, numericality: { greater_than: 0 }
  validates :transaction_type, presence: true, inclusion: { in: [ "Buy", "Sell" ] }
end
