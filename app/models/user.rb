class User < ApplicationRecord
  has_many :folders
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  
  enum role: [:user, :moderator, :admin]
  
  after_initialize :set_default_role, :if => :new_record?
  def set_default_role
    self.role ||= :user
  end
  
  def self.with_role(role)
    where(role: roles[role])
  end

  def self.roles
    { 'User' => 0, 'Moderator' => 1, 'Admin' => 2 }
  end

  def admin?
    role == 'admin'
  end
end
