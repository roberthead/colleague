require "rails_helper"

RSpec.describe School do
  describe "associations" do
    it { is_expected.to belong_to(:resume) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:name) }
  end

  describe "slugification" do
    subject(:school) { build(:school, name: "Blush Magazine", resume: resume) }

    let(:resume) { create(:resume) }

    specify do
      expect {
        school.valid?
      }.to change(school, :slug).from(be_blank).to("blush-magazine")
    end

    context "when saved" do
      before { school.save }

      its(:to_param) { is_expected.to eq "blush-magazine" }
    end
  end

  describe "urls" do
    subject(:school) { build(:school, url:) }

    context "when the url is blank" do
      let(:url) { "" }

      its(:full_url) { is_expected.to be_blank }
      its(:display_url) { is_expected.to be_blank }
    end

    context "when the url contains a protocol" do
      let(:url) { "https://www.bluey.tv/" }

      its(:full_url) { is_expected.to eq "https://www.bluey.tv" }
      its(:display_url) { is_expected.to eq "bluey.tv" }
    end

    context "when the url does not contain a protocol" do
      let(:url) { "bluey.tv" }

      its(:full_url) { is_expected.to eq "https://bluey.tv" }
      its(:display_url) { is_expected.to eq "bluey.tv" }
    end
  end
end
