# frozen_string_literal: true

class Diary < ApplicationRecord
  belongs_to :user

  validates :date_id, presence: true
  validates_length_of :date_id, minimum: 10, maximum: 10
  validates :asleep_at, presence: true
  validates :awake_at, presence: true
  validates :rating, presence: true
  validates_inclusion_of :rating, in: 1..5
end
