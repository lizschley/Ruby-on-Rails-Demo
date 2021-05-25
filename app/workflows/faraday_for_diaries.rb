# frozen_string_literal: true

class FaradayForDiaries
  require 'faraday'
  require 'tzinfo'
  include DiariesControllerHelper

  # params needs id and field to update
  def self.update_diary(params=update_params)
  end

  # params is expected to have the following:
  # date_id: 'YYYY-MM-DD' format and valid date
  # user id: as stored in diaries table
  # asleep_at: valid datetime string in local time (user.time_zone is always America/New_York)
  # awake_at: valid datetime string in local time (user.time_zone is always America/New_York)
  # ratings - integer from 1..5
  def self.create_diary
    url = 'http://127.0.0.1:3000/diaries'
    response = Faraday.post(url) do |req|
      req.params = FaradayForDiaries.create_params
      req.headers = {
        'API-TOKEN' => 'DVrgvayzMwD2fbyujmyo',
        'X-User-Email' => 'lizschley@gmail.com',
        'Content-Type' => 'application/json'
      }
      req.body = req.body.to_json
    end
  end

  def self.get_diary
    url = 'http://127.0.0.1:3000/4ccaa214-326a-4993-b520-9a3019afb13d/2021-05-22'
    response = Faraday.get(url, {},
      {'API-TOKEN' => 'DVrgvayzMwD2fbyujmyo', 'X-User-Email' => 'lizschley@gmail.com'})
  end

  def update_params; end

  # this is used to make manual entry easier
  def self.create_params
    {
      user_id: 1,
      date_id: '2021-05-20',
      asleep_at: '2021-05-21 22:15:00 EDT',
      awake_at: '2021-05-20 04:30:00 EDT',
      rating: 3
    }
  end
end
