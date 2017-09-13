class User < ApplicationRecord
  # informer this model has secure password (gem bcrypt-ruby)
  has_secure_password

  validates_uniqueness_of :email, :username
  before_create { generate_token(:auth_token) }

  def generate_token(column)
    loop do
      self[column] = SecureRandom.urlsafe_base64
      break unless User.exists?(column => self[column])
    end
  end
end
