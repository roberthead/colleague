class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def update?
    user == record
  end

  def destroy?
    return false if user.blank?

    user == record || user.admin?
  end

  class Scope < Scope
  end
end
