class RootController < ApplicationController
  def index
    @gallery_items = GalleryItem.where category_id: 45
  end
end
