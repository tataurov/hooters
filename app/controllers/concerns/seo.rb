module Seo
  extend ActiveSupport::Concern

  included do
    LOGO_OPTIONS = {width: 212, height: 56}
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
    set_meta_tags title: seo_data[:title]
    set_meta_tags description: seo_data[:description]
    set_meta_tags keywords: seo_data[:keywords]
    set_meta_tags canonical: current_url
    set_meta_tags charset: 'utf-8'
    set_meta_tags icon: [{href: '/favicon.png', type: 'image/png' },
                         {href: '/apple-touch-favicon.png', rel: 'apple-touch-icon-precomposed', type: 'image/png'}]
    set_meta_tags og: social_network_params
    set_meta_tags twitter: social_network_params.merge({card: 'summary'})
  end

  def social_network_params
    {title: seo_data[:title],
     description: seo_data[:description],
     site_name: t('general.project_name'),
     type: 'website',
     url: current_url,
     see_also: root_url,
     image: [{
               _: logo_path,
               width: LOGO_OPTIONS[:width],
               height: LOGO_OPTIONS[:height]
             }]
    }
  end
end