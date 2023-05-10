require "rails_helper"

RSpec.describe User do
  it { is_expected.to have_many :resumes }

  it { is_expected.not_to be_admin }
end
