class Transaction < ApplicationRecord
  belongs_to :user

  TRANSACTION_TYPES = %w[buy sell]

  validates :stock_name, presence: true
  validates :quantity, presence: true, numericality: { greater_than: 0 }
  validates :stock_price_per_share, presence: true, numericality: { greater_than: 0 }
  validates :total_price, presence: true, numericality: { greater_than: 0 }
  validates :transaction_type, presence: true, inclusion: { in: TRANSACTION_TYPES }

  before_validation :calculate_total_price

  def calculate_total_price
    self.total_price = quantity * stock_price_per_share
  end
end
