class ApplicationController < ActionController::Base
  before_action :set_cookie

  private

  def set_cookie
    cookies[:user_id] = current_user.id unless current_user.nil?
  end
end
