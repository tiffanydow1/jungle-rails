class User < ActiveRecord::Base
  has_secure_password

  has_many :reviews

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 5 }
  validates :password_confirmation, presence: true


end


