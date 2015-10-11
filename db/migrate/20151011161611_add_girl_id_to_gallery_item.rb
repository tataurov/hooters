class AddGirlIdToGalleryItem < ActiveRecord::Migration
  def change
    add_column :gallery_items, :girl_id, :integer, index: true
  end
end
