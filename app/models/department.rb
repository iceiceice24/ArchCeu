class Department < ApplicationRecord
    has_many :folders
    has_many :users
end
