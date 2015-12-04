class RootController < ApplicationController
  def index
    @girls = GalleryItem.all.sample(50)
  end
end
