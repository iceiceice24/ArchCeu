class AddDepartmentIdToFolders < ActiveRecord::Migration[7.0]
  def change
    add_reference :folders, :department, null: false, foreign_key: true
  end
end
