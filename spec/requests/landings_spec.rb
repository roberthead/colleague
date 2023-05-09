require "rails_helper"

RSpec.describe "Landings" do
  describe "GET /index" do
    it "returns http success" do
      get "/landing"
      expect(response).to redirect_to("/resume")
    end
  end
end
