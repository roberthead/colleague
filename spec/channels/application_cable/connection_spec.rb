require "rails_helper"

RSpec.describe ApplicationCable::Connection do
  specify do
    expect(described_class).to be < ActionCable::Connection::Base
  end
end
