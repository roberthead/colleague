require "rails_helper"

RSpec.describe Role do
  describe "associations" do
    it { is_expected.to belong_to(:employer) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:start_year) }
  end

  describe "dates for sorting" do
    context "when the role has a start year only" do
      subject(:role) { build(:role, start_year: 2010) }

      its(:smart_end_year) { is_expected.to eq(Time.zone.now.year + 1) }
    end

    context "when the role has an end year" do
      subject(:role) { build(:role, start_year: 2010, end_year: 2020) }

      its(:smart_end_year) { is_expected.to eq(2020) }
    end
  end
end
