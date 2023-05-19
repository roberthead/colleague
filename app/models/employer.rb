class Employer < ApplicationRecord
  belongs_to :resume

  has_many :roles, dependent: :destroy

  before_validation :slugify

  validates :name, presence: true

  delegate :slug, to: :resume, prefix: true

  def to_param
    slug
  end

  def smart_url
    return if url.blank?

    if /\Ahttps?:\/\//.match?(url)
      url
    else
      "https://#{url}"
    end
  end

  private

  def slugify
    self.slug = name.to_s.parameterize
  end
end
