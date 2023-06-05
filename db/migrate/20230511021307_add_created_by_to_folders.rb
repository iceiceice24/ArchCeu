class AddCreatedByToFolders < ActiveRecord::Migration[7.0]
  def change
    add_reference :folders, :created_by, null: true, foreign_key: { to_table: :users }
  end
end
