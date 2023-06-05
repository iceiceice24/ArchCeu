class AddCreatedByToActiveStorageBlobs < ActiveRecord::Migration[7.0]
  def change
    add_reference :active_storage_blobs, :created_by, foreign_key: { to_table: :users }, null: true
  end
end
