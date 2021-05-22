class Diary < ApplicationRecord
  belongs_to :user

  validates :date_id, presence: true
  validates_length_of :date_id, minimum: 8, maximum: 8
  validates :asleep_at, presence: true
  validates :awake_at, presence: true
  validates :rating, presence: true
  validates_inclusion_of :rating, :in => 1..5
end
