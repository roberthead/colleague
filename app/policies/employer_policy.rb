class EmployerPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    owner?
  end

  private

  def owner?
    return false unless user
    return false unless record&.resume

    user == record.resume.user
  end

  class Scope < Scope
    def resolve
      return scope.none unless user

      scope.where(resume_id: user.resume_ids)
    end
  end
end
