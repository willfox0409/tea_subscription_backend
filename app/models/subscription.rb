class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates :title, :price, :status, :frequency, :customer_id, :tea_id, presence: true
end
