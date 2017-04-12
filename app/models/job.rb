class Job < ApplicationRecord
  has_many :resumes
  
  validates :title, presence: true
  validates :wage_upper_bound, presence: true
  validates :wage_lower_bound, presence: true
  validates :wage_lower_bound, numericality: { greater_than: 0 }
  validates :wage_upper_bound, numericality: { greater_than_or_equal_to: :wage_lower_bound }

  scope :published, -> { where(is_hidden: false) }
  scope :order_by_wage_lower_bound, -> { order("wage_lower_bound DESC") }
  scope :order_by_wage_upper_bound, -> { order("wage_upper_bound DESC") }
  scope :recent, -> { order("updated_at DESC") }

  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end
end
