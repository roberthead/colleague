require "rails_helper"

RSpec.describe "Landing" do
  before do
    driven_by(:rack_test)
  end

  it "displays a name" do
    visit "/"

    expect(page).to be_present

    visit "/stories.txt"

    expect(page).to have_text("DONE")
  end
end
