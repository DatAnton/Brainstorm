class ExtraTime < ApplicationRecord
  belongs_to :challenge

  validates :time, presence: true

  def diff
    if (self.time - (Time.now.to_i - self.created_at.to_i)) <= 0
      return 0
    else
      self.time - (Time.now.to_i - self.created_at.to_i)
    end
  end

  def expired
    self.diff < 0
  end
end
