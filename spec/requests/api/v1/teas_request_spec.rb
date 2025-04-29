require 'rails_helper'

RSpec.describe "Api::V1::Teas", type: :request do
  describe "GET /index" do
    it "returns a list of teas" do
      tea1 = Tea.create!(title: "English Breakfast", description: "Tasty and strong", temperature: "180°F", brew_time: "4 minutes")
      tea2 = Tea.create!(title: "Earl Grey", description: "Foggy and bright", temperature: "200°F", brew_time: "3 minutes")
      
      get "/api/v1/teas"

      expect(response).to be_successful

      teas = JSON.parse(response.body, symbolize_names: true)

      expect(teas[:data].count).to eq(2)

      expect(teas[:data].first).to have_key(:id)
      expect(teas[:data].first).to have_key(:type)
      expect(teas[:data].first).to have_key(:attributes)

      expect(teas[:data].first[:id]).to eq(tea1.id.to_s)
      expect(teas[:data].first[:attributes][:title]).to eq("English Breakfast")
      expect(teas[:data].first[:attributes][:description]).to eq("Tasty and strong")
      expect(teas[:data].first[:attributes][:temperature]).to eq("180°F")
      expect(teas[:data].first[:attributes][:brew_time]).to eq("4 minutes")

      expect(teas[:data].last[:id]).to eq(tea2.id.to_s)
      expect(teas[:data].last[:attributes][:title]).to eq("Earl Grey")
      expect(teas[:data].last[:attributes][:description]).to eq("Foggy and bright")
      expect(teas[:data].last[:attributes][:temperature]).to eq("200°F")
      expect(teas[:data].last[:attributes][:brew_time]).to eq("3 minutes")
    end
  end
end