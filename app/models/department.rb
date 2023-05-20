class Department < ApplicationRecord
    validates :name, presence: true
    has_many :folders
    has_many :users
end
