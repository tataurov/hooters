class GalleryItem < ActiveRecord::Base
  has_one :gallery_item_image, as: :imageable, dependent: :destroy, class_name: 'GalleryItemImage'
  has_many :gallery_item_categories, dependent: :destroy
  has_many :categories, :through => :gallery_item_categories

  belongs_to :girl

  accepts_nested_attributes_for :gallery_item_image, :reject_if => :all_blank
  accepts_nested_attributes_for :gallery_item_categories
  accepts_nested_attributes_for :girl
end