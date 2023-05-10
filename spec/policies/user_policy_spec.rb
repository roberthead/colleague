require "rails_helper"

RSpec.describe UserPolicy do
  subject(:policy) { described_class }

  # Create admin first to accomodate User#ensure_primary_admin
  let!(:admin) { create(:user, admin: true) }

  let(:visitor) { nil }
  let(:other_user) { create(:user) }
  let(:user) { create(:user) }

  let(:record) { user }

  permissions :index? do
    it { is_expected.to permit(visitor) }
    it { is_expected.to permit(other_user) }
    it { is_expected.to permit(admin) }
  end

  permissions :show? do
    it { is_expected.to permit(visitor, record) }
    it { is_expected.to permit(other_user, record) }
    it { is_expected.to permit(admin, record) }
  end

  permissions :new?, :create? do
    it { is_expected.not_to permit(visitor, record) }
    it { is_expected.not_to permit(other_user, record) }
  end

  permissions :edit?, :update? do
    it { is_expected.not_to permit(visitor, record) }
    it { is_expected.not_to permit(other_user, record) }
    it { is_expected.not_to permit(admin, record) }

    it { is_expected.to permit(user, record) }
  end

  permissions :destroy? do
    it { is_expected.not_to permit(visitor, record) }
    it { is_expected.not_to permit(other_user, record) }

    it { is_expected.to permit(user, record) }
    it { is_expected.to permit(admin, record) }
  end
end
