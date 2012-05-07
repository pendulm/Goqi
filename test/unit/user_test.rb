require 'test_helper'

class UserTest < ActiveSupport::TestCase
  fixtures :users

  test "empty email is invalid" do
    user = User.new
    assert user.invalid?
  end

  test "test wrong format email" do
    user = User.new
    user.password_digest = "xyzabc"
    ok = %w{ a@b.c a.b@c.d a.b.c@d.e }
    bad = %w{ a@b a.b a.b.c @b.c }
    
    ok.each do |email|
      user.email = email
      assert user.valid?, "#{email} must be valid."
    end

    bad.each do |email|
      user.email = email
      assert user.invalid?, "#{email} must be invalid."
    end
  end

  test "test this email available for signup" do
    ok = %w{ nonexist@args.me }
    bad = %w{ a@b a.b a.b.c @b.c } << ''
    bad += [users(:mike), users(:jack)].map &:email

    ok.each do |email|
      assert User.is_email_available?(email), "#{email} must be available."
    end

    bad.each do |email|
      assert !User.is_email_available?(email), "#{email} can't be available."
    end
  end
end
