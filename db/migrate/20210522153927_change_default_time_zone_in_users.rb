# frozen_string_literal: true

class ChangeDefaultTimeZoneInUsers < ActiveRecord::Migration[6.0]
  def change
    change_column_default :users, :time_zone, from: 'Eastern Time (US & Canada)', to: 'America/New_York'
  end
end
