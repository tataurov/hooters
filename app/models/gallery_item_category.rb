class GalleryItemCategory < ActiveRecord::Base
  belongs_to :gallery_item
  belongs_to :category
end