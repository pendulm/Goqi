require 'test_helper'

class SessionControllerTest < ActionController::TestCase
  def assert_header_before_login
    assert_nil session[:uid]
    assert_select "header a", 3
    assert_select "header a" do |links|
      links.each_with_index do |link, i|
        assert link, @header_link_before_login[i]
      end
    end
  end

  setup do
    @user_mike = users(:mike)
    @header_link_before_login = %w{ index login signup }.map { |s| I18n.t s}
    @header_link_after_login = %w{ index logout }.map { |s| I18n.t s}
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_header_before_login
  end
  
  test "should get login" do
    get :login
    assert_response :success
    assert_header_before_login
  end

  test "should get signup" do
    get :signup
    assert_response :success
    assert_header_before_login
  end

  test "login to create session success" do
    post :create_session, email: @user_mike.email , password: 'aaa123'
    assert_redirected_to root_path
    assert_equal session[:uid], @user_mike.id
  end

  test "login to create session fail" do
    post :create_session, email: @user_mike.email , password: 'xxxooo'
    assert_redirected_to login_path
    assert_nil session[:uid]
    assert_equal I18n.t(:login_fail_notice), flash[:notice]
  end


  test "sign up to create user success" do
    assert_difference('User.count') do
      post :create_user, user: { email: "new_user@args.me",
                          password: "aaa123",
                          password_confirmation: "aaa123" }
    end
    assert_redirected_to root_path
    assert_not_nil session[:uid]
    assert_equal I18n.t(:welcome_notice), flash[:notice]
  end

  test "signup to create user fail" do
    assert_no_difference('User.count') do
      post :create_user, user: { email: @user_mike.email,
                          password: "aaa123",
                          password_confirmation: "aaa123" }
    end
    assert_response :success
    assert_nil session[:uid]
  end

  test "logout" do 
    session[:uid] = @user_mike.id
    delete :logout
    assert_redirected_to root_path
    assert_nil session[:uid] = nil
    assert_equal I18n.t(:logout_notice), flash[:notice]
  end

end
