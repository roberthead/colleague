class Employer < ApplicationRecord
  belongs_to :resume

  before_validation :slugify

  validates :name, presence: true

  def to_param
    slug
  end

  private

  def slugify
    self.slug = name.to_s.parameterize
  end
end
