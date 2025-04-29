class Customer < ApplicationRecord
  has_many :subscriptions
  has_many :teas, through: :subscriptions 

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :address, presence: true
end
