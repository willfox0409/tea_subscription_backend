class Tea < ApplicationRecord
  has_many :customers, through: :subscriptions
end
