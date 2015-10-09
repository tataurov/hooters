class RootController < ApplicationController
  def index
    @gallery_items = GalleryItem.all
  end
end