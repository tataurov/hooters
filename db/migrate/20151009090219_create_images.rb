class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :image_file_name, null: false
      t.string :title, null: true
      t.string :image_content_type, null: false
      t.integer :image_file_size, null: false
      t.integer :imageable_id, null: false
      t.string :imageable_type, null: false
      t.timestamps
    end

    add_index :images, [:imageable_id, :imageable_type], :unique => true
  end
end
