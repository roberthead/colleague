require "rails_helper"

RSpec.describe ApplicationMailer do
  specify do
    expect(described_class).to be < ActionMailer::Base
  end
end
