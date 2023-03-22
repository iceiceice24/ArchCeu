class AddNameToFolders < ActiveRecord::Migration[7.0]
  def change
    add_column :folders, :name, :string
  end
end
