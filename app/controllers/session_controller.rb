class SessionController < ApplicationController
  skip_before_filter :authorize
  def index
    @user = get_current_user
    if @user
      render
    else
      render action: :login
    end
  end

  def login
  end

  def signup
    @user = User.new
  end

  def logout
    session[:uid] = nil
    redirect_to root_path, notice: t(:logout_notice)
  end

  def create_session
    user = User.find_by_email params[:email]
    if user and user.authenticate(params[:password])
      session[:uid] = user.id
      if path = session[:path_for_restore]
        session[:path_for_restore] = nil
        redirect_to path
      else
        redirect_to root_path
      end
    else
      redirect_to login_path, notice: t(:login_fail_notice)
    end
  end

  def create_user
    @user = User.new(params[:user])

    if @user.save
      session[:uid] = @user.id
      redirect_to root_path, notice: @user.nickname.blank? ?
        t(:nickname_urge) : t(:welcome_notice, name: @user.nickname)
    else
      render action: "signup"
    end
  end
end
