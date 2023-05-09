require "rails_helper"

RSpec.describe "Resumes" do
  describe "GET /resume" do
    it "returns http success" do
      get "/resume"
      expect(response).to have_http_status(:success)
    end
  end
end
