class GalleryController < ApplicationController
  def index
    @gallery_items = GalleryItem.where(category_id: params[:id]).paginate(:page => params[:page], :per_page => 30)
  end
end