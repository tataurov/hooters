class GirlsController < ApplicationController
  def index
    @girls = Girl
      .all
      .includes(:gallery_items => [:gallery_item_image])
      .paginate(:page => params[:page], :per_page => 48)
  end

  def show
    @girl = Girl.find_by_id(params[:id])
  end
end