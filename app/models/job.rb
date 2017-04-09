class Job < ApplicationRecord
  validates :title, presence: true
  validates :wage_upper_bound, presence: true
  validates :wage_lower_bound, presence: true
  validates :wage_lower_bound, numericality: { greater_than: 0 }
  validates :wage_upper_bound, numericality: { greater_than_or_equal_to: :wage_lower_bound }
  scope :recent, -> { order("created_at DESC")}
  
  def publish!
    self.is_hidden = false
    self.save
  end

  def hide!
    self.is_hidden = true
    self.save
  end
end
