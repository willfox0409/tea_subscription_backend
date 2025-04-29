class Tea < ApplicationRecord
  has_many :subscriptions
  has_many :customers, through: :subscriptions
end
