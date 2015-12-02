class CreateGalleryItemCategories < ActiveRecord::Migration
  def change
    create_table :gallery_item_categories do |t|
      t.integer :category_id, index: true
      t.integer :gallery_item_id, index: true
      t.timestamps
    end
  end
end
