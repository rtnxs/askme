class User < ApplicationRecord

  validates :name, :username, presence: true
  validates :email, uniqueness: true
end
