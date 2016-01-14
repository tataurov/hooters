class GalleryController < ApplicationController
  def index
    redirect_to :action => :index, id: category.id_with_slug unless params[:id] == category.id_with_slug
    set_seo_context
    load_gallery_items
  end

  def load_gallery_items
    return @gallery_items if defined? @gallery_items

    @gallery_items = GalleryItem.joins(:gallery_item_categories)
      .includes(:girl)
      .where('gallery_item_categories.category_id=?', params[:id].split('_').first)
      .paginate(:page => params[:page], :per_page => 30)
  end

  def category
    return @category if defined? @category
    @category = Category.find_by_id_with_slug(params[:id])
  end

  def set_seo_context
    @seo_context = {
      title: category.title
    }
  end
end