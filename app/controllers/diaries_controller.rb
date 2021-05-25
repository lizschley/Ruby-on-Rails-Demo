# frozen_string_literal: true

class DiariesController < ApplicationController
  protect_from_forgery with: :null_session, only: [:show_with_token, :update, :create]
  before_action :authenticate_user!, only: [:index, :show]
  acts_as_token_authentication_handler_for User,
    only: [:show_with_token, :update, :create], fallback_to_devise: false
  before_action :get_user

  include DiariesControllerHelper

  # GET /
  def index
    @buttons = prepare_instance_variable
  end

  # Send back one days diary. If given day has no results, sends back new record with default datetimes
  # GET /:id/:date_id (YYYY-MM-DD string format)
  def show
    diary = show_one_diary(@user, params[:date_id])
    render(json: diary.to_json, status: 400) and return if diary.key?(:error)
    render(json: diary.to_json, status: 200)
  end

  # GET /:uuid/:date_id (YYYY-MM-DD string format)
  def show_with_token
   if @user.nil?
      render(json: 'unauthenticated', status:401)
      return
    end
    diary = show_one_diary(@user, params[:date_id])
    render(json: diary.to_json, status: 400) and return if diary.key?(:error)
    render(json: diary.to_json, status: 200)
  end

  # PUT /diaries
  def update; end

  # POST /diaries
  def create
    @diary = Diary.new(allowed_params)

    if @diary.save
      render (json: {status: successfully created}.to_json, status: 201)
    else
      render(json: {error: @diary.errors}.to_json, status: 400)
    end
  end

  private

  def get_user
    @user = current_user
  end

  private

  def allowed_params
    params.permit(
      :user_id,
      :date_id,
      :asleep_at,
      :awake_at,
      :rating)
  end
end
