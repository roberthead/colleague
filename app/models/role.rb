class Role < ApplicationRecord
  belongs_to :employer

  validates :title, presence: true
  validates :start_year, presence: true, inclusion: {in: 1900..Time.zone.today.year}
end
