require "rails_helper"

RSpec.describe EmployerPolicy do
  subject(:policy) { described_class }

  # Create admin first to accomodate User#ensure_primary_admin
  let!(:admin) { create(:user, admin: true) }

  let(:owner) { create(:user) }
  let(:user) { create(:user) }
  let(:visitor) { nil }
  let(:resume) { create(:resume, user: owner) }
  let(:record) { create(:employer, resume:) }

  describe "permissions" do
    permissions :index? do
      it { is_expected.to permit(owner) }
      it { is_expected.to permit(user) }
      it { is_expected.to permit(visitor) }
    end

    permissions :show? do
      it { is_expected.to permit(owner, record) }
      it { is_expected.to permit(user, record) }
      it { is_expected.to permit(visitor, record) }
    end

    permissions :new?, :create? do
      it { is_expected.not_to permit(admin, record) }
      it { is_expected.to permit(owner, record) }
      it { is_expected.not_to permit(user, record) }
      it { is_expected.not_to permit(visitor, record) }
    end

    permissions :edit?, :update? do
      it { is_expected.not_to permit(admin, record) }
      it { is_expected.to permit(owner, record) }
      it { is_expected.not_to permit(user, record) }
      it { is_expected.not_to permit(visitor, record) }
    end

    permissions :destroy? do
      it { is_expected.to permit(admin, record) }
      it { is_expected.to permit(owner, record) }
      it { is_expected.not_to permit(user, record) }
      it { is_expected.not_to permit(visitor, record) }
    end
  end

  describe "scope" do
    before { record }

    specify { expect(Pundit.policy_scope!(owner, Employer)).to eq([record]) }
    specify { expect(Pundit.policy_scope!(user, Employer)).to eq([]) }
    specify { expect(Pundit.policy_scope!(visitor, Employer)).to eq([]) }
  end
end
