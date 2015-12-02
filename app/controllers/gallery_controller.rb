class GalleryController < ApplicationController
  def index
    @gallery_items = GalleryItem.joins(:gallery_item_categories).where('gallery_item_categories.category_id=?', params[:id]).paginate(:page => params[:page], :per_page => 30)
  end
end