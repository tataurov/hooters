module Seo
  extend ActiveSupport::Concern

  included do
    helper_method :current_url
    helper_method :page_meta_tags
  end

  # Public: Current page url
  # Returns: String
  def current_url
    request.base_url + request.fullpath
  end

  def logo_path
    ActionController::Base.helpers.asset_path('logo.png')
  end

  # Public: Create parameters for meta tags
  # Returns Hash
  def page_meta_tags
    set_meta_tags title: t('pages.title')
    set_meta_tags description: t('pages.description')
    set_meta_tags keywords: ::Category.all.map(&:title).join(', ')
    set_meta_tags canonical: current_url
    set_meta_tags charset: 'utf-8'
  end
end