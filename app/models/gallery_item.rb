class GalleryItem < ActiveRecord::Base
  has_one :gallery_item_image, as: :imageable, dependent: :destroy, class_name: 'GalleryItemImage'
  has_many :gallery_item_categories
  has_many :categories, :through => :gallery_item_categories
  belongs_to :girl
end