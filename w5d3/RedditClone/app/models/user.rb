require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :username, :password_digest, :password, :session_token

  validates :username, :password_digest, :session_token, presence: true

  def password=(password)
    self.password_digest = BCrypt::Password.create(password)
  end

  def reset_session_token
    self.session_token = SecureRandom.base64
  end

  def authenticated?(password)
    BCrypt::Password.new(self.password_digest) == password
  end
end
