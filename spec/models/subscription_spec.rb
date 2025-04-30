require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "Relationships" do
    it { is_expected.to belong_to(:customer) }
    it { is_expected.to belong_to(:tea) }
  end

  describe "Validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:status) }
    it { is_expected.to validate_presence_of(:frequency) }
    it { is_expected.to validate_presence_of(:customer_id) }
    it { is_expected.to validate_presence_of(:tea_id) }
  end

  describe ".with_status" do
    let(:customer) { Customer.create!(first_name: "Test", last_name: "User", email: "test@example.com", address: "123 St") }
    let(:tea) { Tea.create!(title: "Green Tea", description: "Chill", temperature: "180°F", brew_time: "3 min") }
    
    it "returns only subscriptions with the given status" do
      active = Subscription.create!(title: "Active Sub", status: "active", frequency: "monthly", price: 10.0, customer: customer, tea: tea)
      cancelled = Subscription.create!(title: "Cancelled Sub", status: "cancelled", frequency: "monthly", price: 10.0, customer: customer, tea: tea)
  
      results = Subscription.with_status("active")
  
      expect(results).to include(active)
      expect(results).not_to include(cancelled)
      expect(results.count).to eq(1)
    end
  end
end
