require "rails_helper"

RSpec.describe ResumePolicy do
  subject(:policy) { described_class }

  # Create admin first to accomodate User#ensure_primary_admin
  let!(:admin) { create(:user, admin: true) }

  let(:visitor) { nil }
  let(:user) { create(:user) }
  let(:owner) { create(:user) }

  let(:record) { create(:resume, user: owner) }

  permissions :index? do
    it { is_expected.to permit(visitor) }
    it { is_expected.to permit(user) }
    it { is_expected.to permit(admin) }
  end

  permissions :show? do
    it { is_expected.to permit(visitor, record) }
    it { is_expected.to permit(user, record) }
    it { is_expected.to permit(admin, record) }
  end

  permissions :new?, :create? do
    it { is_expected.not_to permit(visitor) }
    it { is_expected.to permit(user) }
  end

  permissions :edit?, :update? do
    it { is_expected.not_to permit(visitor, record) }
    it { is_expected.not_to permit(user, record) }
    it { is_expected.not_to permit(admin, record) }

    it { is_expected.to permit(owner, record) }
  end

  permissions :destroy? do
    it { is_expected.not_to permit(visitor, record) }
    it { is_expected.not_to permit(user, record) }

    it { is_expected.to permit(owner, record) }
    it { is_expected.to permit(admin, record) }
  end
end
