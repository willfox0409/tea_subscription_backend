require 'rails_helper'

RSpec.describe "Api::V1::Customers", type: :request do
  describe "GET /index" do
    it "returns a list of customers" do
      customer1 = Customer.create!(first_name: "John", last_name: "Lennon", email: "john@yahoo.com", address: "123 Test St")
      customer2 = Customer.create!(first_name: "Ringo", last_name: "Starr", email: "ringo@aol.com", address: "345 Demo St")

      get "/api/v1/customers"

      expect(response).to be_successful

      customers = JSON.parse(response.body, symbolize_names: true)

      expect(customers[:data].count).to eq(2)

      expect(customers[:data].first).to have_key(:id)
      expect(customers[:data].first).to have_key(:type)
      expect(customers[:data].first).to have_key(:attributes)

      expect(customers[:data].first[:id]).to eq(customer1.id.to_s)
      expect(customers[:data].first[:attributes][:first_name]).to eq("John")
      expect(customers[:data].first[:attributes][:last_name]).to eq("Lennon")
      expect(customers[:data].first[:attributes][:email]).to eq("john@yahoo.com")
      expect(customers[:data].first[:attributes][:address]).to eq("123 Test St")

      expect(customers[:data].last[:id]).to eq(customer2.id.to_s)
      expect(customers[:data].last[:attributes][:first_name]).to eq("Ringo")
      expect(customers[:data].last[:attributes][:last_name]).to eq("Starr")
      expect(customers[:data].last[:attributes][:email]).to eq("ringo@aol.com")
      expect(customers[:data].last[:attributes][:address]).to eq("345 Demo St")
    end
  end
end