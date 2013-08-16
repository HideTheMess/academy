require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :username, :password_digest, :password, :session_token

  validates :username, :password_digest, :session_token, presence: true
  validates :username, uniqueness: true

  has_many :modded_subs,
  class_name: 'Sub',
  foreign_key: :mod_id,
  primary_key: :id

  has_many :authored_links,
  class_name: 'Link',
  foreign_key: :author_id,
  primary_key: :id

  def password=(password)
    return nil if password.blank?
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token
    self.session_token = SecureRandom.base64
  end

  def authenticated?(password)
    BCrypt::Password.new(self.password_digest) == password
  end
end
