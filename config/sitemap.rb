# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = 'http://seeboobs.ru'
SitemapGenerator::Sitemap.compress = false
SitemapGenerator::Sitemap.create_index = false
SitemapGenerator::Sitemap.include_root = false

SitemapGenerator::Sitemap.create do
  add root_path, priority: 1.0, :changefreq => 'daily'

  Girl.find_each do |girl|
    add girl_path(girl.id_with_slug), priority: 0.9, :changefreq => 'daily'
  end

  add categories_path, priority: 0.9, :changefreq => 'monthly'
  add girls_path, priority: 0.9, :changefreq => 'daily'
  add girls_path(page: 2), priority: 0.9, :changefreq => 'daily'
  add girls_path(page: 3), priority: 0.9, :changefreq => 'daily'
end
