class Category < ActiveRecord::Base
   has_many :gallery_items, :through => :gallery_item_categories
   has_many :gallery_item_categories
end