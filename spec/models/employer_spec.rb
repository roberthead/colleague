require "rails_helper"

RSpec.describe Employer do
  describe "associations" do
    it { is_expected.to belong_to(:resume) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "slugification" do
    subject(:employer) { build(:employer, name: "Blush Magazine") }

    let(:resume) { create(:resume, user: user) }

    specify do
      expect {
        employer.valid?
      }.to change(employer, :slug).from(be_blank).to("blush-magazine")
    end
  end

  describe "#smart_url" do
    subject(:employer) { build(:employer, url:) }

    context "when the url is blank" do
      let(:url) { "" }

      its(:smart_url) { is_expected.to be_blank }
    end

    context "when the url contains a protocol" do
      let(:url) { "https://www.bluey.tv" }

      its(:smart_url) { is_expected.to eq "https://www.bluey.tv" }
    end

    context "when the url does not contain a protocol" do
      let(:url) { "bluey.tv" }

      its(:smart_url) { is_expected.to eq "https://bluey.tv" }
    end
  end
end
