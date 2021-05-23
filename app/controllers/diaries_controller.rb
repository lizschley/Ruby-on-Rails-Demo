# frozen_string_literal: true

class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user

  include DiariesControllerHelper

  # GET /
  def index
    @buttons = prepare_instance_variable
  end

  # Send back one days diary. If given day has no results, sends back new record with default datetimes
  # GET /:uuid/:date_id (YYYYMMDD string format)
  def show
    render json: { User: 'unauthorized'}, status: 401
  end

  # PUT /diaries
  def update; end

  # POST /diaries
  def create; end

  private

  def get_user
    @user = current_user
  end
end
