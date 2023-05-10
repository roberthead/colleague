require "rails_helper"

RSpec.describe StyleHelper do
  describe "#bem" do
    specify { expect(helper.bem("a")).to eq("a") }
    specify { expect(helper.bem("a", "b")).to eq("a__b") }
    specify { expect(helper.bem("a", nil, "c")).to eq("a a--c") }
    specify { expect(helper.bem("a", "b", "c")).to eq("a__b a__b--c") }
    specify { expect(helper.bem("a", "b", %w[c d])).to eq("a__b a__b--c a__b--d") }
  end
end
