class CreateGalleryItems < ActiveRecord::Migration
  def change
    create_table :gallery_items do |t|
      t.string :title, null: false, index: true
      t.integer :rate
      t.integer :category_id, null: false, index: true
      t.timestamps
    end
  end
end
