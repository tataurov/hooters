module Parser
  module Oxfol
    require 'open-uri'
    require 'nokogiri'

    def self.download_all_categories
      categories = get_categories

      categories.each do |category|
        c = Category.create(title: category[:title])
        puts '+++++++++++++++++++++++++++++++++++++++'
        puts 'Started category: ' + category[:title]
        puts '+++++++++++++++++++++++++++++++++++++++'

        next unless Parser::Oxfol.get_items_from_category(category, c.id)

        puts '+++++++++++++++++++++++++++++++++++++++'
        puts 'Ends category: ' + category[:title] + ', with time'
        puts '+++++++++++++++++++++++++++++++++++++++'
      end
    end

    def self.get_items_from_category(category, id)
      page = 1

      loop do
	puts category
	uri = URI.parse(category[:link])
        items = Parser::Oxfol.get_gallery_items(uri.scheme + '://' + uri.host + uri.path + '/page' + page.to_s + '/')
        return if items.count == 0
        Parser::Oxfol.create_gallery_items(items, id)
        puts '+++++++++++++++++++++++++++++++++++++++'
        puts 'Page: ' + page.to_s + ', Category:' + category[:title] + ' loaded.'
        puts '+++++++++++++++++++++++++++++++++++++++'
        page += 1
      end
    end

    def self.get_gallery_items(page)
      source = 'http://oxfol.org/b/'


      begin
        file = open(page)
        page = Nokogiri::HTML(file) do |page|

        end
      rescue OpenURI::HTTPError => e
        if e.message == '404 Not Found'
          # handle 404 error
        else
          raise e
        end
      end
         objects = []

          page.css('.js-topic').each do |preview|
            objects.push({
                         img: preview.css('img').first['src'].sub!("_250crop", ""),
                         title: (preview.css('.titleh1').first.content)
                       })
          end

          return objects

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
