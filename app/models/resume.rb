class Resume < ApplicationRecord
  belongs_to :user

  has_many :employers, dependent: :destroy
  has_many :schools, dependent: :destroy

  before_validation :slugify

  def phone
    super.presence || user.phone
  end

  def email
    super.presence || user.email
  end

  def preferred_pronouns
    super.presence || user.preferred_pronouns
  end

  def name
    alias_name.presence || user&.name
  end

  def to_param
    slug
  end

  private

  def slugify
    self.slug = "#{name} #{field}".parameterize
  end
end
