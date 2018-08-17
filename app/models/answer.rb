class Answer < ApplicationRecord
  before_save :set_defaults

  belongs_to :challenge

  validates :text, presence: true

  private
  def set_defaults
    self.cost ||= Random.rand 0..1000
    self.impact ||= Random.rand 0..1000
  end
end
