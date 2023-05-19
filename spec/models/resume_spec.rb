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
end
