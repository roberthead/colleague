class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_many :resumes, dependent: :destroy

  before_validation :ensure_name
  before_create :ensure_primary_admin

  validates :name, presence: true

  def self.primary_admin
    where(admin: true).order(:created_at).first
  end

  private

  def ensure_primary_admin
    self.admin = true if User.primary_admin.nil?
  end

  def ensure_name
    return if name.present?

    self.name = email.split("@").first.split(/\W+/).map(&:titleize).join(" ")
  end
end
