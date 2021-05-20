class DiariesController < ApplicationController
  before_action :authenticate_user!
  before_action :get_user
  
  def index
  end
  
  private
  
  def get_user
    @user = current_user
  end
end