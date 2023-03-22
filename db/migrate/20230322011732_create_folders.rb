class CreateFolders < ActiveRecord::Migration[7.0]
  def change
    create_table :folders do |t|
      t.integer :created_by_uid
      t.integer :parent_id
      t.string :url

      t.timestamps
    end
  end
end
