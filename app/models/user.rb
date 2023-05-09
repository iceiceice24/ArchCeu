class User < ApplicationRecord
  has_many :folders
  validates :email, presence: true, format: { with: /\A[\w+\-.]+@ceu\.edu\.ph\z/i }
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, omniauth_providers: [:google_oauth2]
  
  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name
      user.avatar_url = auth.info.image

    end
  end  
  
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

  enum department: [:NONE, :ICT, :Registrar, :SciTech, :Dentistry]
  
  after_initialize :set_default_department, :if => :new_record?
  def set_default_department
    self.department ||= :NONE
  end
  
  def self.with_department(department)
    where(department: departments[department])
  end

  def self.department
    { 'NONE' => 0, 'ICT' => 1, 'Registrar' => 2, 'SciTech' => 3, 'Dentistry' => 4 }
  end

end
