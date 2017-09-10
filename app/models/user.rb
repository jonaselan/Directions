class User < ApplicationRecord
  # informer this model has secure password (gem bcrypt-ruby)
  has_secure_password

  validates_uniqueness_of :email, :username
end
