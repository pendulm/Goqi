class Label < ActiveRecord::Base
  attr_accessible :name, :user_id, :user
  belongs_to :user
  has_and_belongs_to_many :friendships
  has_many :friends, through: :friendships

  validates :name, :user_id, presence: true
  validates :name, uniqueness: { scope: :user_id }
end
