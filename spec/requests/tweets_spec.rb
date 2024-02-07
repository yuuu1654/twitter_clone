require 'rails_helper'

RSpec.describe "Tweets", type: :request do
  describe "GET /create" do
    it "returns http success" do
      get "/tweets/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /show" do
    it "returns http success" do
      get "/tweets/show"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/tweets/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/tweets/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /delete" do
    it "returns http success" do
      get "/tweets/delete"
      expect(response).to have_http_status(:success)
    end
  end

end
