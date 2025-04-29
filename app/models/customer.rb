class Customer < ApplicationRecord
  has_many :subscriptions
  has_many :teas, through: :subscriptions 
end
