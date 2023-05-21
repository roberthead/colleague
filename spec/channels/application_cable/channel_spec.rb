require "rails_helper"

RSpec.describe ApplicationCable::Channel do
  specify do
    expect(described_class).to be < ActionCable::Channel::Base
  end
end
