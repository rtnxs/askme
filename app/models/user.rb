class User < ApplicationRecord

  has_many :questions

  validates :name, :username, presence: true
  validates :email, uniqueness: true
end
