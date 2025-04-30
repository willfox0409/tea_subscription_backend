class Tea < ApplicationRecord
  has_many :subscriptions
  has_many :customers, through: :subscriptions

  validates :title, :description, :temperature, :brew_time, presence: true
end
