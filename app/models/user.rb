class User < ApplicationRecord
  has_many :folders
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
