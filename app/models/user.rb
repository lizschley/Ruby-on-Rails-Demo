# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :diaries, dependent: :destroy

  before_validation :set_uuid, on: :create
  validates_uniqueness_of :uuid

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
