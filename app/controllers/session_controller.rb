# coding: utf-8
class SessionController < ApplicationController
  def index
  end

  def login
  end

  def signup
    @user = User.new
  end

  def logout
    session[:uid] = nil
    redirect_to root_path, notice: "已成功注销"
  end

  def create_session
    user = User.find_by_email params[:email]
    if user and user.authenticate(params[:password])
      session[:uid] = user.id
      redirect_to root_path
    else
      redirect_to login_path, notice: "用户名或密码错误"
    end
  end

  def create_user
    @user = User.new(params[:user])

    if @user.save
      session[:uid] = @user.id
      redirect_to root_path, notice: '感谢您的注册'
    else
      render action: "signup"
    end
  end
end
