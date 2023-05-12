require "rails_helper"

RSpec.describe "profiles/show.html.haml" do
  specify do
    assign(:current_user, create(:user))
    render
    expect(rendered).to match(/<h2>Profile<\/h2>/)
  end
end
