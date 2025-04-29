class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates :title, :price, :frequency, :customer_id, :tea_id, presence: true
  validates :status, presence: true, inclusion: { in: ["active", "cancelled"] }

  scope :with_status, ->(status) { where(status: status) }
end
