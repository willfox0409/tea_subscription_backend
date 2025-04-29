class Customer < ApplicationRecord
  has_many :teas, through: :subscriptions 
end
