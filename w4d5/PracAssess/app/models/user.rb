class User < ActiveRecord::Base
  attr_accessible :password, :username, :name, :session_token

  has_many :incoming_follows,
  :class_name => 'Follow',
  :foreign_key => :followed_id,
  :primary_key => :id

  has_many :outgoing_follows,
  :class_name => 'Follow',
  :foreign_key => :follower_id,
  :primary_key => :id

  has_many :followers,
  :through => :incoming_follows,
  :source => :follower

  has_many :follows,
  :through => :outgoing_follows,
  :source => :followed

  def gen_token
    new_token = SecureRandom.base64(16)
    self.session_token = new_token

    new_token
  end

end
