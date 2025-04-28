require 'rails_helper'

RSpec.describe "Api::V1::Subscriptions", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/api/v1/subscriptions/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/api/v1/subscriptions/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/api/v1/subscriptions/update"
      expect(response).to have_http_status(:success)
    end
  end

end
