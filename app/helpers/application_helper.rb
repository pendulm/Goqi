module ApplicationHelper
  def get_current_user
    User.find_by_id session[:uid]
  end
end
