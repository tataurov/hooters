class GalleryItem < ActiveRecord::Base
  has_one :gallery_item_image, as: :imageable, dependent: :destroy, class_name: 'GalleryItemImage'
  belongs_to :girl
end