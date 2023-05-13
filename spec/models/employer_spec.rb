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
end
