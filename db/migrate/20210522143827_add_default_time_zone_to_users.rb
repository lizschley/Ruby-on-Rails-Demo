# frozen_string_literal: true

class AddDefaultTimeZoneToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :time_zone, :string, default: 'Eastern Time (US & Canada)'
  end
end
