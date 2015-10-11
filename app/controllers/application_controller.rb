class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :load_categories

  def load_categories
    @categories = Category.all.order(:title)
    @girls = Girl.all.order(:name)
  end
end
