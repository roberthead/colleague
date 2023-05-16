require "rails_helper"

RSpec.describe User do
  it { is_expected.to have_many :resumes }

  it { is_expected.not_to be_admin }

  describe ".primary_admin" do
    let(:first_user) { create(:user) }
    let(:second_user) { create(:user) }

    before do
      first_user
      second_user
    end

    describe "auto-assignment to first user" do
      specify { expect(first_user).to be_admin }
      specify { expect(second_user).not_to be_admin }
      specify { expect(described_class.primary_admin).to eq(first_user) }
    end
  end

  describe "#name" do
    context "when name is not set" do
      context "when email username is simple" do
        let(:user) { create(:user, email: "jimmy@jimmyjames.com", name: "") }

        specify { expect(user.name).to eq("Jimmy") }
      end

      context "when email username contains non-word characters" do
        let(:user) { create(:user, email: "first.last@gmail.com", name: "") }

        specify { expect(user.name).to eq("First Last") }
      end
    end
  end
end
