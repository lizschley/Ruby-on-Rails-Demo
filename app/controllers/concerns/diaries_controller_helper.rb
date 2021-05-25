# frozen_string_literal: true

# preliminary work for index page
module DiariesControllerHelper
  require 'date'

  def prepare_instance_variable
    idx_helper = DiariesIndexHelper.new @user
    buttons = idx_helper.index_view_input
    buttons
  end

  def show_one_diary(user, date_id)
    return { error: 'date must be YYYY-MM-DD format' } if not valid_date_format?(date_id)
    diary = user.diaries.where(date_id: params[:date_id])
    return default_diary(date_id) if diary.empty?
    diary[0]
  end

  def valid_date_format?(date_id)
    format_ok = date_id.match(/\d{4}-\d{2}-\d{2}/)
    parseable = Date.strptime(date_id, '%Y-%m-%d') rescue false
    format_ok && parseable ? true : false
  end

  def default_diary(date_id)
    date_and_time = '%Y-%m-%d %H:%M:%S %Z'
    awake_at = DateTime.strptime("#{date_id} 06:26:30 UTC", date_and_time)
    day_before = 1.days.ago(awake_at).strftime('%Y-%m-%d')
    asleep_at = DateTime.strptime("#{day_before} 20:43:52 UTC", date_and_time)
    {asleep_at: asleep_at, awake_at: awake_at}
  end
end
