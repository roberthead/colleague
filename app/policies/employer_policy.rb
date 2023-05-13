class EmployerPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    user.present?
  end

  def update?
    user == record.user
  end

  def destroy?
    return false if user.blank?

    user == record.user || user.admin?
  end

  class Scope < Scope
    def resolve
      return scope.none unless user

      scope.where(resume_id: user.resume_ids)
    end
  end
end
