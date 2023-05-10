class Folder < ApplicationRecord
  belongs_to :user
    validates :name, presence: true
  
    belongs_to :parent_folder, class_name: 'Folder', optional: true
    has_many :subfolders, class_name: 'Folder', foreign_key: 'parent_folder_id', dependent: :destroy
    has_many :child_folders, class_name: 'Folder', foreign_key: 'parent_folder_id'  
    has_many_attached :files, dependent: :destroy

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

    def files=(attachables)
      attachables = Array(attachables).compact_blank
 
     if attachables.any?
       attachment_changes["files"] =
         ActiveStorage::Attached::Changes::CreateMany.new("files", self, files.blobs + attachables)
     end
   end

    def self.roots
      where(parent_folder_id: nil)
    end
    
  end
