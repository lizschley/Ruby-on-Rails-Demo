# frozen_string_literal: true

class CreateDiaries < ActiveRecord::Migration[6.0]
  def change
    create_table :diaries do |t|
      t.string :date_id, null: false
      t.belongs_to :user, null: false, foreign_key: true
      t.datetime :asleep_at, null: false
      t.datetime :awake_at, null: false
      t.integer :rating, null: false

      t.timestamps
      t.index %i[uuid date_id], unique: true
    end
  end
end
