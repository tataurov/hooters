module Parser
  module Oxfol
    require 'open-uri'
    require 'nokogiri'

    def self.get_gallery_items(page)
      source = 'http://oxfol.org/b/hot'
      result = {}

      page = Nokogiri::HTML(open(source.to_s + page))

      objects = []

      page.css('.js-topic').each do |preview|
        objects.push({
                       img: preview.css('img').first['src'].sub!("_250crop", ""),
                       title: (preview.css('.titleh1').first.content)
                     })
      end

      objects
    end

    def self.create_gallery_items
      items = Parser::Oxfol.get_gallery_items('')
      puts items
      items.each do |item|
        new_item = GalleryItem.create(title: item[:title], category_id: 2)
        img = new_item.build_gallery_item_image
        img.download_from_url(item[:img])

        new_item.save
      end
    end

    def self.get_categories
      source = 'http://oxfol.org/blogs'
      page = Nokogiri::HTML(open(source.to_s))

      categories = []

      page.css('#blogs-list-original .cell-name').each do |category|
        categories.push({
                       title: (category.css('a').first.content)
                     })
      end

      categories
    end

  end
end