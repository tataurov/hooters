class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :load_categories
  layout :layout_by_resource

  def load_categories
    @categories = Category.all.order(:title)
    @girls = Girl.where.not(photos_count: 0).order(photos_count: :desc)
  end

  protected

  def layout_by_resource
    if devise_controller?
      'devise'
    else
      'application'
    end
  end
end
