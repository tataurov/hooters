class GirlsController < ApplicationController
  def index
    @girls = Girl
      .all
      .includes(:gallery_items => [:gallery_item_image])
      .paginate(:page => params[:page], :per_page => 48)
  end

  def show
    redirect_to :action => :show, id: girl.id_with_slug unless params[:id] == girl.id_with_slug
    girl
  end

  def girl
    return @girl if defined? @girl
    @girl = Girl.find_by_id_with_slug(params[:id])
  end
end