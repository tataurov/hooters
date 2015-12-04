class RootController < ApplicationController
  def index
    @girls = GalleryItem.order(:created_at).limit(50)
  end
end
