# frozen_string_literal: true

class DiariesIndexHelper
  require 'tzinfo'

  def initialize(current_user)
    @buttons = []
    @dates = []
    @avg_rating = ''
    @user = current_user
  end

  def index_view_input
    date_array
    loop_through_dates_for_buttons
    @buttons
  end

  def date_array
    temp = *(1..7).reverse_each
    temp.each { |minus_days| add_date_to_array(minus_days) }
  end

  def add_date_to_array(minus_days)
    tz = TZInfo::Timezone.get(@user.time_zone)
    # now will be UTC
    now = tz.now
    # now.to_s(:iso8601) is "2021-05-22T16:18:55Z"
    # now.to_s(:db) is "2021-05-22 16:18:55"
    @dates << minus_days.days.ago(now)
  end

  def loop_through_dates_for_buttons
    @dates.each { |dt| format_button(dt.in_time_zone(@user.time_zone)) }
  end

  def format_button(local_dt)
    @buttons << create_buttons(local_dt)
  end

  def create_buttons(local_dt)
    date_id = format_time_with_zone(local_dt, '%Y-%m-%d')
    found = Diary.exists?(user_id: @user.id, date_id: date_id)
    button(found, date_id, date_hash(local_dt))
  end

  def date_hash(local_dt)
    {
      month: format_time_with_zone(local_dt, '%b'),
      weekday: format_time_with_zone(local_dt, '%a'),
      day: format_time_with_zone(local_dt, '%-d')
    }
  end

  # date_id will be the date you go to sleep: yyyymmdd
  def button(found, date_id, new_date)
    ret_btn = "<a href='#{button_href(date_id)}' "
    ret_btn += "class='#{button_classes(found)}'>"
    ret_btn += "#{button_text(found, new_date)}</a>"
    ret_btn
  end

  def button_href(date_id)
    "/diaries/#{@user.id}/#{date_id}"
  end

  def button_text(found, new_date)
    addedit = found ? 'edit >' : 'add >'
    text = new_date[:weekday]
    text += "<br>#{new_date[:month]}"
    text += "<br><span class='day_int'>#{new_date[:day]}</span>"
    text += "<br>#{addedit}"
    text
  end

  def button_classes(found)
    addedit = found ? 'btn_edit' : 'btn_add'
    "#{addedit} button diary"
  end

  def format_time_with_zone(dt, format_string)
    # results will vary based on both timezone and format
    dt.strftime(format_string)
  end
end
