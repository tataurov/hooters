class Category < ActiveRecord::Base
   URL_SEPARATOR = '_'

   has_many :gallery_items, :through => :gallery_item_categories
   has_many :gallery_item_categories, dependent: :destroy

   validates_presence_of :title, :slug
   before_validation :generate_slug

   def self.find_by_id_with_slug(id_with_slug)
      find(id_with_slug.split(URL_SEPARATOR).first)
   end

   def id_with_slug
      [id, slug].join(URL_SEPARATOR)
   end

   protected

   def generate_slug
      self.slug = title.parameterize(sep = URL_SEPARATOR)
   end
end