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

  def sort_value
    [-smart_end_year, -smart_start_year, name]
  end

  private

  def slugify
    self.slug = name.to_s.parameterize
  end

  def smart_start_year
    roles.map(&:start_year).compact.min || default_start_year
  end

  def smart_end_year
    roles.map(&:end_year).compact.max || default_end_year
  end

  def default_start_year
    @default_start_year ||= Time.zone.now.year
  end

  def default_end_year
    @default_end_year ||= Time.zone.now.year + 1
  end
end
