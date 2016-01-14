class GirlsController < ApplicationController
  def index
    @girls = Girl
      .all
      .joins('LEFT JOIN gallery_items on girls.id = gallery_items.girl_id')
      .where('gallery_items.girl_id IS NOT NULL')
      .group('girls.id')
      .includes(:gallery_items => [:gallery_item_image])
      .order(:name)
      .paginate(:page => params[:page], :per_page => 48)

  end

  def show
    redirect_to :action => :show, id: girl.id_with_slug unless params[:id] == girl.id_with_slug
    set_seo_context
    girl
  end

  def girl
    return @girl if defined? @girl
    @girl = Girl.find_by_id_with_slug(params[:id])
  end

  def set_seo_context
    @seo_context = {
      name: girl.name,
      photos_count: girl.photos_count
    }
  end
end