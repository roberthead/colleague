require "rails_helper"

RSpec.describe Resume do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:employers) }
    it { is_expected.to have_many(:schools) }
  end

  describe "slugification" do
    subject(:resume) { build(:resume, user: user, field: "juggler") }

    let(:user) { create(:user, name: "Joseph Thompson") }

    specify do
      expect {
        resume.valid?
      }.to change(resume, :slug).from("").to("joseph-thompson-juggler")
    end
  end

  describe "#phone" do
    context "when neither the user nor the resume has a phone number" do
      let(:user) { create(:user) }
      let(:resume) { create(:resume, user: user) }

      specify do
        expect(resume.phone).to be_blank
      end
    end

    context "when the user has a phone number and the resume does not" do
      let(:user) { create(:user, phone: "323-555-1212") }
      let(:resume) { create(:resume, user:) }

      it "returns the user's phone number" do
        expect(resume.phone).to eq("323-555-1212")
      end
    end

    context "when the user has a phone number and the resume also does" do
      let(:user) { create(:user, phone: "323-555-1212") }
      let(:resume) { create(:resume, user:, phone: "310-555-1212") }

      it "returns the resume's phone number" do
        expect(resume.phone).to eq("310-555-1212")
      end
    end
  end

  describe "#email" do
    let(:user) { create(:user, email: "joe99@example.com") }

    context "when resume has an email address" do
      subject(:resume) { create(:resume, user: user, email: "joseph.thompson@example.com") }

      its(:email) { is_expected.to eq "joseph.thompson@example.com" }
    end

    context "when the resume does not have an email address" do
      subject(:resume) { create(:resume, user: user) }

      its(:email) { is_expected.to eq "joe99@example.com" }
    end
  end

  describe "#preferred_pronouns" do
    context "when neither the user nor the resume has pronouns" do
      let(:user) { create(:user) }
      let(:resume) { create(:resume, user: user) }

      specify do
        expect(resume.preferred_pronouns).to be_blank
      end
    end

    context "when the user has pronouns and the resume does not" do
      let(:user) { create(:user, preferred_pronouns: "he/him") }
      let(:resume) { create(:resume, user:) }

      it "returns the user's pronouns" do
        expect(resume.preferred_pronouns).to eq("he/him")
      end
    end

    context "when the user has pronouns and the resume also does" do
      let(:user) { create(:user, preferred_pronouns: "he/him") }
      let(:resume) { create(:resume, user:, preferred_pronouns: "he/they") }

      it "returns the resume's pronouns" do
        expect(resume.preferred_pronouns).to eq("he/they")
      end
    end
  end

  describe "portfolio urls" do
    subject(:resume) { build(:resume, portfolio_url:) }

    context "when the url is blank" do
      let(:portfolio_url) { "" }

      its(:full_portfolio_url) { is_expected.to be_blank }
      its(:display_portfolio_url) { is_expected.to be_blank }
    end

    context "when the url contains a protocol" do
      let(:portfolio_url) { "https://github.com/myusername" }

      its(:full_portfolio_url) { is_expected.to eq "https://github.com/myusername" }
      its(:display_portfolio_url) { is_expected.to eq "github.com/myusername" }
    end

    context "when the url does not contain a protocol" do
      let(:portfolio_url) { "github.com/myusername" }

      its(:full_portfolio_url) { is_expected.to eq "https://github.com/myusername" }
      its(:display_portfolio_url) { is_expected.to eq "github.com/myusername" }
    end
  end
end
