class User < ApplicationRecord
  validates :username, presence: true, length: { minimum: 6, maximum: 12 }
  validates :email, presence: true, length: { minimum: 10, maximum: 300 }
end
