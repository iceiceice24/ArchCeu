class Folder < ApplicationRecord
    validates :name, presence: true
  
    belongs_to :parent_folder, class_name: 'Folder', optional: true
    has_many :subfolders, class_name: 'Folder', foreign_key: 'parent_folder_id', dependent: :destroy
    has_many :child_folders, class_name: 'Folder', foreign_key: 'parent_folder_id'
  
    has_many_attached :files, dependent: :destroy

    def self.roots
      where(parent_folder_id: nil)
    end
  end
  