require 'rails_helper'

RSpec.describe "Api::V1::Subscriptions", type: :request do
  describe "GET /index" do
    it "returns a list of subscriptions" do
      customer1 = Customer.create!(first_name: "John", last_name: "Lennon", email: "john@yahoo.com", address: "123 Test St")
      customer2 = Customer.create!(first_name: "Ringo", last_name: "Starr", email: "ringo@aol.com", address: "345 Demo St")

      tea1 = Tea.create!(title: "English Breakfast", description: "Tasty and strong", temperature: "180°F", brew_time: "4 minutes")
      tea2 = Tea.create!(title: "Earl Grey", description: "Foggy and bright", temperature: "200°F", brew_time: "3 minutes")

      subscription1 = Subscription.create!(title: "Abbey Road", price: 10.00, status: "active", frequency: "weekly", customer: customer1, tea: tea1)
      subscription2 = Subscription.create!(title: "Paul's Farm", price: 15.00, status: "active", frequency: "monthly", customer: customer2, tea: tea2)

      get "/api/v1/subscriptions"

      expect(response).to be_successful

      subscriptions = JSON.parse(response.body, symbolize_names: true)

      expect(subscriptions[:data].count).to eq(2)

      expect(subscriptions[:data].first).to have_key(:id)
      expect(subscriptions[:data].first).to have_key(:type)
      expect(subscriptions[:data].first).to have_key(:attributes)

      expect(subscriptions[:data].first[:id]).to eq(subscription1.id.to_s)
      expect(subscriptions[:data].first[:attributes][:title]).to eq("Abbey Road")
      expect(subscriptions[:data].first[:attributes][:status]).to eq("active")
      expect(subscriptions[:data].first[:attributes][:frequency]).to eq("weekly")

      expect(subscriptions[:data].last[:id]).to eq(subscription2.id.to_s)
      expect(subscriptions[:data].last[:attributes][:title]).to eq("Paul's Farm")
      expect(subscriptions[:data].last[:attributes][:status]).to eq("active")
      expect(subscriptions[:data].last[:attributes][:frequency]).to eq("monthly")
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
