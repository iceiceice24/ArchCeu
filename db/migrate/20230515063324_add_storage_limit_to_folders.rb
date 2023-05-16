class AddStorageLimitToFolders < ActiveRecord::Migration[7.0]
  def change
    add_column :folders, :storage_limit, :integer
  end
end
