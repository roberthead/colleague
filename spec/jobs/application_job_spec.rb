require "rails_helper"

RSpec.describe ApplicationJob do
  specify do
    expect(described_class).to be < ActiveJob::Base
  end
end
