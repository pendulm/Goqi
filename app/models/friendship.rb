class Friendship < ActiveRecord::Base
  attr_accessible :from, :reamrk_name, :to
  belongs_to :user
  belongs_to :receiver, class_name: 'User', foreign_key: 'to'
  has_and_belongs_to_many :labels
end
