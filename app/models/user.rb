class User < ApplicationRecord
  # informer this model has secure password (gem bcrypt-ruby)
  has_secure_password

  has_many :attempt_login_faileds

  validates_uniqueness_of :email, :username
  before_create { generate_token(:auth_token) }

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    loop do
      self[column] = SecureRandom.urlsafe_base64
      break unless User.exists?(column => self[column])
    end
  end
end
