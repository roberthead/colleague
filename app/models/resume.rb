class Resume < ApplicationRecord
  belongs_to :user

  def phone
    super.presence || user.phone
  end

  def email
    super.presence || user.email
  end

  def name
    alias_name.presence || user.name
  end
end
