class UserPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    admin?
  end

  private

  def owner?
    user == record
  end

  class Scope < Scope
  end
end
