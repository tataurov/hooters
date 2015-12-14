class RootController < ApplicationController
  def index
    @girls = GalleryItem.all.sample(50)
  end

  def robots
    render "robots/#{Rails.env}", :layout => false, :content_type => 'text/plain'
  end
end
