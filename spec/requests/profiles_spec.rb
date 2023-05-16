require "rails_helper"

RSpec.describe "Profiles" do
  let(:user) { create(:user) }

  describe "GET /profile" do
    context "when signed in" do
      before do
        login_as(user, scope: :user)
      end

      specify do
        get "/profile"
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "PATCH /profile" do
    context "when signed in" do
      before do
        login_as(user, scope: :user)
      end

      context "with valid params" do
        specify do
          patch "/profile", params: {user: {name: "Lila Emerson"}}
          expect(response).to redirect_to(profile_path)
        end

        specify do
          patch "/profile", params: {user: {name: "Lila Emerson"}}
          expect(flash[:notice]).to be_present
        end
      end

      context "when save fails" do
        before do
          allow_any_instance_of(User).to receive(:save).and_return(false)
        end

        specify do
          patch "/profile", params: {user: {name: "Lila Emerson"}}
          expect(flash.now[:alert]).to be_present
        end
      end
    end
  end
end
