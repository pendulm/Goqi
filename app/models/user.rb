class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation, :nickname
  has_secure_password

  before_save { |user| user.email.downcase! }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: true
  validate :password, length: { minimum: 6 }
  validate :password_confirmation, presence: true

  def self.is_email_available? test_email
    VALID_EMAIL_REGEX =~ test_email and self.find_by_email(test_email) == nil
  end
end
