class Role < ApplicationRecord
  belongs_to :employer

  validates :title, presence: true
  validates :start_year, presence: true, inclusion: {in: 1900..Time.zone.today.year}

  def smart_end_year
    end_year || Time.zone.today.year + 1
  end
end
