require 'rails_helper'

RSpec.describe "Api::V1::Subscriptions", type: :request do
  describe "GET /index" do
    it "returns a list of subscriptions with slim attributes" do
      customer = Customer.create!(first_name: "John", last_name: "Lennon", email: "john@example.com", address: "123 Main St")
      tea = Tea.create!(title: "Green Tea", description: "Light and earthy", temperature: "175°F", brew_time: "3 min")

      subscriptions = [
        Subscription.create!(title: "Morning Brew", price: 9.99, status: "active", frequency: "weekly", customer: customer, tea: tea),
        Subscription.create!(title: "Evening Calm", price: 12.50, status: "cancelled", frequency: "monthly", customer: customer, tea: tea)
      ]

      get "/api/v1/subscriptions"

      expect(response).to be_successful

      data = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(data.count).to eq(2)

      data.each_with_index do |sub, i|
        expect(sub).to have_key(:id)
        expect(sub).to have_key(:type)
        expect(sub[:type]).to eq("subscription")

        attrs = sub[:attributes]
        expect(attrs).to include(
          title: subscriptions[i].title,
          status: subscriptions[i].status,
          frequency: subscriptions[i].frequency,
          price: subscriptions[i].price.to_s
        )

        expect(attrs).not_to have_key(:customer)
        expect(attrs).not_to have_key(:tea)
      end
    end
  end

  describe "GET /show" do
    it "returns a single subscription with customer and tea nested" do
      customer = Customer.create!(first_name: "George", last_name: "Harrison", email: "george@test.com", address: "789 Example Rd")
      tea = Tea.create!(title: "Green Harmony", description: "Smooth and mellow", temperature: "175°F", brew_time: "3 minutes")
      subscription = Subscription.create!(title: "Mystic Morning", price: 12.50, status: "active", frequency: "monthly", customer: customer, tea: tea)

      get "/api/v1/subscriptions/#{subscription.id}"

      expect(response).to be_successful

      sub = JSON.parse(response.body, symbolize_names: true)

      expect(sub[:data]).to have_key(:id)
      expect(sub[:data][:id]).to eq(subscription.id.to_s)
      expect(sub[:data]).to have_key(:type)
      expect(sub[:data][:attributes]).to have_key(:title)
      expect(sub[:data][:attributes][:title]).to eq("Mystic Morning")
      expect(sub[:data][:attributes]).to have_key(:status)
      expect(sub[:data][:attributes][:status]).to eq("active")

      expect(sub[:data][:attributes][:customer]).to have_key(:id)
      expect(sub[:data][:attributes][:customer][:attributes][:first_name]).to eq("George")

      expect(sub[:data][:attributes][:tea]).to have_key(:id)
      expect(sub[:data][:attributes][:tea][:attributes][:title]).to eq("Green Harmony")
    end

    it "returns a 404 if subscription is not found" do
      get "/api/v1/subscriptions/999999"
  
      expect(response).to have_http_status(:not_found)
  
      error = JSON.parse(response.body, symbolize_names: true)
  
      expect(error).to have_key(:error)
      expect(error[:error]).to match(/Couldn't find Subscription/)
    end
  end

  describe "PATCH /update" do
    it "can cancel a subscription" do
      customer = Customer.create!(first_name: "Paul", last_name: "McCartney", email: "paul@test.com", address: "456 Abbey Ln")
      tea = Tea.create!(title: "Peppermint Peace", description: "Minty and fresh", temperature: "190°F", brew_time: "4 minutes")
      subscription = Subscription.create!(title: "Sergeant's Brew", price: 18.00, status: "active", frequency: "weekly", customer: customer, tea: tea)

      patch "/api/v1/subscriptions/#{subscription.id}", params: {
        subscription: { status: "cancelled" }
      }

      expect(response).to be_successful

      updated_sub = JSON.parse(response.body, symbolize_names: true)

      expect(updated_sub[:data]).to have_key(:id)
      expect(updated_sub[:data][:id]).to eq(subscription.id.to_s)
      expect(updated_sub[:data][:attributes][:status]).to eq("cancelled")
      expect(updated_sub[:data][:attributes][:title]).to eq("Sergeant's Brew")
      expect(updated_sub[:data][:attributes][:frequency]).to eq("weekly")
    end

    it "returns a 404 if subscription is not found" do
      patch "/api/v1/subscriptions/999999", params: { subscription: {status: "cancelled"} }
  
      expect(response).to have_http_status(:not_found)
  
      error = JSON.parse(response.body, symbolize_names: true)
  
      expect(error).to have_key(:error)
      expect(error[:error]).to match(/Couldn't find Subscription/)
    end

    it "returns a 400 if subscription params are missing" do
      customer = Customer.create!(first_name: "Yoko", last_name: "Ono", email: "yoko@peace.com", address: "Ocean Ave")
      tea = Tea.create!(title: "Zen Blend", description: "delicious!", temperature: "185°F", brew_time: "3 minutes")
      subscription = Subscription.create!(title: "Let it Be", price: 17.00, status: "active", frequency: "monthly", customer: customer, tea: tea)
  
      patch "/api/v1/subscriptions/#{subscription.id}", params: { status: "cancelled" }
  
      expect(response).to have_http_status(:bad_request)
  
      error = JSON.parse(response.body, symbolize_names: true)
      expect(error).to have_key(:error)
      expect(error[:error]).to match(/param is missing or the value is empty: subscription/)
    end

    it "returns a 422 if status is invalid" do
      customer = Customer.create!(first_name: "Linda", last_name: "McCartney", email: "linda@test.com", address: "123 Veggie Blvd")
      tea = Tea.create!(title: "Chamomile Calm", description: "Smooth and sleepy", temperature: "190°F", brew_time: "5 minutes")
      subscription = Subscription.create!(title: "Peace Pack", price: 15.00, status: "active", frequency: "monthly", customer: customer, tea: tea)
  
      patch "/api/v1/subscriptions/#{subscription.id}", params: {
        subscription: { status: "maybe" } 
      }
  
      expect(response).to have_http_status(:unprocessable_entity)
  
      error = JSON.parse(response.body, symbolize_names: true)
  
      expect(error).to have_key(:error)
      expect(error[:error]).to match(/Validation failed: Status is not included/)
    end
  end
end
