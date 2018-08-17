class Challenge < ApplicationRecord
  before_save :default_values

  # Validation rules
  validates :time, presence: true
  validates :mode, presence: true
  validates :problem, presence: true

  # Relations
  has_many :answers, dependent: :destroy
  has_many :extra_times, dependent: :destroy

  # Set default values for empty fields
  def default_values
    self.mode ||= 'challenge_quick'
  end

  def diff
    if (self.time - (Time.now.to_i - self.created_at.to_i)) <= 0
      return 0
    else
      self.time - (Time.now.to_i - self.created_at.to_i)
    end
  end

  def session
    time = self.extra_times.select{|x| x.expired != true }.map{|y| y.diff}.reduce(:+) || 0
    time + self.diff
  end

  def expired
    self.session <= 0
  end
end
