require "rails_helper"

RSpec.describe "Landing", type: :system do
  before do
    driven_by(:rack_test)
  end

  scenario "visiting the root url" do
    visit "/"

    expect(page).to have_text("Robert Emerson Head")
  end
end
