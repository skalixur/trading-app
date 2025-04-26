class User < ApplicationRecord
  has_many :transactions, dependent: :destroy
  has_many :holdings, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  validates :name, presence: true
  validates :balance, numericality: { greater_than_or_equal_to: 0 }

  def admin?
    is_admin
  end

  def approved?
    is_approved
  end

  def activate_for_authentication?
    super && approved?
  end
end
