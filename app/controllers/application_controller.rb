class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authorize

  private
  def get_current_user
    User.find_by_id session[:uid]
  end

  def authorize
    unless get_current_user
      session[:path_for_restore] = request.path
      redirect_to login_url, notice: "please log in"
    end
  end
end
