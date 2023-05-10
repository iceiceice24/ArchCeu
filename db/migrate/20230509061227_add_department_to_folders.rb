class AddDepartmentToFolders < ActiveRecord::Migration[7.0]
  def change
    add_column :folders, :department, :integer, default: 0
  end
end
