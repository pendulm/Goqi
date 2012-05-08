# coding: utf-8
class SessionController < ApplicationController
  def index
    @petitions = Friendship.where to: session[:uid], status: false
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
      redirect_to root_path
    else
      redirect_to login_path, notice: t(:login_fail_notice)
    end
  end

  def create_user
    @user = User.new(params[:user])

    if @user.save
      session[:uid] = @user.id
      redirect_to root_path, notice: t(:welcome_notice)
    else
      render action: "signup"
    end
  end
end
