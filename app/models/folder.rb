class Folder < ApplicationRecord
  belongs_to :user
  belongs_to :department
  validates :name, presence: true

  belongs_to :parent_folder, class_name: 'Folder', optional: true
  has_many :subfolders, class_name: 'Folder', foreign_key: 'parent_folder_id', dependent: :destroy
  has_many :child_folders, class_name: 'Folder', foreign_key: 'parent_folder_id'  
  has_many_attached :files, dependent: :destroy


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
