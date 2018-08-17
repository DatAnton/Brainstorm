class Answer < ApplicationRecord
  belongs_to :challenge

  validates :text, presence: true
end
