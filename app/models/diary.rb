# frozen_string_literal: true

class Diary < ApplicationRecord
  belongs_to :user

  validates :date_id, presence: true
  validates_length_of :date_id, minimum: 10, maximum: 10
  validates :asleep_at, presence: true
  validates :awake_at, presence: true
  validates :rating, presence: true
  validates_inclusion_of :rating, in: 1..5
  validate :dates_are_valid, :date_format

  def dates_are_valid
    if awake_at && asleep_at && awake_at < asleep_at
      errors.add(:awake_at, "happens after you fall asleep")
    end
  end

  def date_format
    format_ok = date_id.match(/\d{4}-\d{2}-\d{2}/)
    parseable = begin
      Date.strptime(date_id, '%Y-%m-%d')
    rescue StandardError
      errors.add(:date_id, 'must be a valid date')
    end
    if not format_ok
      errors.add(:date_id, 'must be in the YYYY-MM-DD format')
    end
  end
end
