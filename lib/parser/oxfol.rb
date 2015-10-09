module Parser
  module Oxfol
    require 'open-uri'
    require 'nokogiri'

    def self.download_all_categories
      categories = get_categories

      categories.all.each do |category|
        c = Category.create(title: category[:title])
        puts '+++++++++++++++++++++++++++++++++++++++'
        puts 'Started category: ' + category[:title]
        puts '+++++++++++++++++++++++++++++++++++++++'

        Parser::Oxfol.get_items_from_category(category, c.id)

        puts '+++++++++++++++++++++++++++++++++++++++'
        puts 'Ends category: ' + category[:title] + ', with time'
        puts '+++++++++++++++++++++++++++++++++++++++'
      end
    end

    def self.get_items_from_category(category, id)
      page = 1

      loop do
        items = Parser::Oxfol.get_gallery_items(category[:link] + '/page' + page.to_s + '/')
        break if items.count == 0
        Parser::Oxfol.create_gallery_items(items, id)
        puts '+++++++++++++++++++++++++++++++++++++++'
        puts 'Page: ' + page + ', Category:' + category[:title] + ' loaded.'
        puts '+++++++++++++++++++++++++++++++++++++++'
        page += 1
      end
    end

    def self.get_gallery_items(page)
      source = 'http://oxfol.org/b/'

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

    def self.create_gallery_items(items, category_id)
      items.each do |item|
        new_item = GalleryItem.create(title: item[:title], category_id: category_id)
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
                       title: category.css('a').first.content,
                       link: category.css('a').first['href']
                     })
      end

      categories
    end

  end
end