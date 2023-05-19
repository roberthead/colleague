class Employer < ApplicationRecord
  belongs_to :resume

  has_many :roles, dependent: :destroy

  accepts_nested_attributes_for :roles, allow_destroy: true

  before_validation :slugify

  validates :name, presence: true

  delegate :slug, to: :resume, prefix: true

  def to_param
    slug
  end

  def full_url
    return if url.blank?

    url = self.url.sub(/\/$/, "") # Remove trailing slash
    if /\Ahttps?:\/\//.match?(url)
      url
    else
      "https://#{url}"
    end
  end

  def display_url
    return if url.blank?

    full_url.gsub(/\Ahttps?:\/\/(www\.)?/, "")
  end

  private

  def slugify
    self.slug = name.to_s.parameterize
  end
end
