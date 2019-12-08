require 'openssl'

class User < ApplicationRecord
  ITERATIONS = 20_000
  DIGEST = OpenSSL::Digest::SHA256.new
  USERNAME_REGEXP = /\A\w+\z/
  EMAIL_REGEXP = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  BGCOLOR_REGEXP = /#([a-f\d]{6}|[a-f\d]{3})\z/i

  attr_accessor :password

  has_many :questions, dependent: :destroy

  validates :email, :username, presence: true, uniqueness: true
  validates :username, length: { maximum: 40 }, format: { with: USERNAME_REGEXP }
  validates :email, format: { with: EMAIL_REGEXP }
  validates :password, presence: true, on: :create
  validates_confirmation_of :password
  validates :bgcolor, format: { with: BGCOLOR_REGEXP }, on: :update

  before_save :encrypt_password
  before_validation :downcase!, on: [ :create, :update ]

  def self.hash_to_string(password_hash)
    password_hash.unpack('H*')[0]
  end

  def self.authenticate(email, password)
    user = find_by(email: email.downcase)
    return nil unless user.present?
    hashed_password = User.hash_to_string(
        OpenSSL::PKCS5.pbkdf2_hmac(
            password, user.password_salt, ITERATIONS, DIGEST.length, DIGEST
        )
    )
    return user if user.password_hash == hashed_password
    nil
  end

  def encrypt_password
    if password.present?
      self.password_salt = User.hash_to_string(OpenSSL::Random.random_bytes(16))
      self.password_hash = User.hash_to_string(
          OpenSSL::PKCS5.pbkdf2_hmac(
              password, password_salt, ITERATIONS, DIGEST.length, DIGEST
          )
      )
    end
  end

  private

  def downcase!
    self.username&.downcase!
    self.email&.downcase!
  end
end

