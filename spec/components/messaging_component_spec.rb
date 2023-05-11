require "rails_helper"

RSpec.describe MessagingComponent, type: :component do
  let(:flash) { nil }
  let(:component) { described_class.new(flash: flash) }

  specify do
    render_inline(component)
    expect(page).to be_present
  end

  context "when flash is empty" do
    let(:flash) { {} }

    it "does not render any messages" do
      render_inline(component)
      expect(page).not_to have_css(".messaging__message")
    end
  end

  context "when flash has a notice" do
    let(:flash) { { notice: "Hello" } }

    it "renders the notice" do
      render_inline(component)
      expect(page).to have_css(".messaging__message", text: "Hello")
    end
  end
end
