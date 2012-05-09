class Friendship < ActiveRecord::Base
  attr_accessible :from, :remark_name, :to, :friend
  belongs_to :owner, class_name: 'User', foreign_key: 'from'
  belongs_to :friend, class_name: 'User', foreign_key: 'to'
  has_and_belongs_to_many :labels

  validate :status, :from, :to, presence: true
  validates :to, uniqueness: { scope: :from }

  def get_identifier
    if remark_name.blank?
      return friend.nickname_or_email
    end
    remark_name
  end
end
