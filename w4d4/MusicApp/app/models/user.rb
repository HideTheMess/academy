require 'bcrypt'

class User < ActiveRecord::Base
  attr_accessible :email, :password_hash, :session_token, :password

  validates :email, :password_hash, presence: true
  validates :email, uniqueness: true

  def password=(new_password)
    self.password_hash = BCrypt::Password.create(new_password)
  end

  def reset_session_token!
    self.session_token = SecureRandom.base64(16)
    self.save!

    self.session_token
  end

  def verify_password?(password)
    BCrypt::Password.new(self.password_hash) == password
  end
end
