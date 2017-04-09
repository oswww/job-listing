class Job < ApplicationRecord
  validates :title, presence: true
  validates :wage_upper_bound, presence: true
  validates :wage_lower_bound, presence: true
  validates :wage_lower_bound, numericality: { greater_than: 0 }
  validates :wage_upper_bound, numericality: { greater_than_or_equal_to: :wage_lower_bound }
end
