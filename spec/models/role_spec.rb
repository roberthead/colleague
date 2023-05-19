require "rails_helper"

RSpec.describe Role do
  describe "associations" do
    it { is_expected.to belong_to(:employer) }
  end

  describe "validations" do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:start_year) }
  end
end
